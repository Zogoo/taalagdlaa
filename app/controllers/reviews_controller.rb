class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find params[:id]
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
  end

  def vote
    @review = Review.find params[:id]
    @review.update(vote: @review.vote + params[:vote]&.to_i)
  end

  def spam
    @review = Review.find params[:id]
    @review.update(spam: @review.spam + params[:spam]&.to_i)
  end
end
