class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :product

  # 廣播
  after_create_commit {
    broadcast_prepend_to 'kitty', partial: 'comments/comment',
                                  target: 'comment_area'
  }
end
