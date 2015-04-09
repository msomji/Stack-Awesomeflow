class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :responses, as: :post, dependent: :destroy

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true
  validates :user_id, presence: true
end