class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_picture, PictureUploader
  validate :picture_size
  validates :profile_picture, presence: true
  
  has_many :items, :dependent => :destroy
  
  has_many :orders, :dependent => :destroy
  has_many :items, through: :orders

  has_many :likes, :dependent => :destroy
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


  # //Search Helpers
  def self.search(param)
      param.strip!
      to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
      return nil unless to_send_back
      to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%" )
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id}
  end
  # //search helper ends


  private

  def picture_size
    if profile_picture.size > 5.megabytes
      errors.add(:profile_picture, "should be less than 5 MB")
    end
  end




end
