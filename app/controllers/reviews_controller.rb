class ReviewsController < ApplicationController
  def index
    @reviews = review_company.reviews.active
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new(company: review_company, user: review_owner)
  end

  def create
    @review = Review.create(review_params.merge!(company: review_company, user: review_owner).merge!(mentioned))
  end

  def vote
    @review = review_company.reviews.find(params[:id])

    if params[:type] == 'up' ? @review.vote_up! : @review.vote_down!
      render json: { notice: 'Review was successfully voted.' }, status: :accepted
    else
      render json: { notice: 'Could not vote this review' }, status: :unprocessable_entity
    end
  end

  def spam
    @review = review_company.reviews.find(params[:id])

    if @review.mark_as_spam!
      render json: { notice: 'Review was successfully reported.' }, status: :accepted
    else
      render json: { notice: 'Could not reported this review' }, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.permit(:company_id, :company_name)
  end

  def review_params
    params.require(:review).permit(
      :comment,
      :rate,
      :vote,
      :spam,
      :service_rating,
      :access_rating,
      :comfort_rating,
      :specific_ratings,
      :tags
    )
  end

  def review_owner
    @review_owner ||= User.find(params[:user_id])
  end

  def review_company
    @review_company ||= Company.find(company_params[:company_id])
  end

  def mentioned
    params[:reply_id].present? ? { mention: { comment: params[:reply_id] } } : {}
  end
end
