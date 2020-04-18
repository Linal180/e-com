class Item < ApplicationRecord

  belongs_to :user
  has_many :orders
  has_many :user, through: :orders

  has_many :likes
  has_many :users, through: :likes

  mount_uploader :picture, PictureUploader
  validates :name, :picture, presence: true
  validate :picture_size
  
  

  def already_liked?(item, user)
    like = Like.where(item_id: item.id, user_id: user.id)
    if like.empty?
      return false
    else
      return true
    end
  end

  
  
  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5 MB")
    end
  end

end