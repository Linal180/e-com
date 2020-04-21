class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_picture, PictureUploader
  validate :picture_size
  validates :profile_picture, presence: true
  has_many :items
  has_many :orders
  has_many :items, through: :orders

  has_many :likes
  has_many :items, through: :likes



  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end


  def already_included?(item, user)
    have = Order.where(item_id: item.id, user_id: user.id)
    if have.empty?
      return false
    else
      return true
    end

  end 

  def get_orders
    orders = Order.where(user_id: id)
    return orders
  end 


  private

  def picture_size
    if profile_picture.size > 5.megabytes
      errors.add(:profile_picture, "should be less than 5 MB")
    end
  end




end
