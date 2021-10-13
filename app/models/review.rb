class Review < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :photos

  enum status: %i[active hidden suspended deleted]

  def increase_vote
    self.vote = vote + 1
  end

  def increase_vote!
    increase_vote
    save
  end

  def mark_as_spam
    self.spam = spam + 1
  end

  def mark_as_spam!
    mark_as_spam
    save
  end
end
