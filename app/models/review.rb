class Review < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :photos

  enum status: %i[active hidden suspended deleted]

  def vote_up
    self.votes = votes + 1
  end

  def vote_up!
    vote_up
    save
  end

  def vote_down
    self.votes = votes - 1
  end

  def vote_down!
    vote_down
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
