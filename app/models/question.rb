class Question < ActiveRecord::Base
  belongs_to :user, inverse_of: :questions
  has_many :votes, as: :votable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :responses, as: :post, dependent: :destroy

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true
  validates :user, presence: true

  def get_best_answer_id
    self.answers.find_by(is_best: true).id || 0
  end

  def mark_best(answer_id)
    self.answers.update_all(is_best: false)
    Answer.find_by(id: answer_id).update(is_best: true)
  end
end