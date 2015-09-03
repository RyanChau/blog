class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  # if you have an instance variable @article containing an article, you can retrieve all the comments belonging to that article
  # as an array using @article.comments.
  validates :title, presence: true,
                    length: {minimum: 5}    # ensure 5 characters long
end
