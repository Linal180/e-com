class Item < ApplicationRecord

  belongs_to :user
  has_many :orders, :dependent => :destroy
  has_many :users, through: :orders

  has_many :likes, :dependent => :destroy
  has_many :users, through: :likes

  mount_uploader :picture, PictureUploader
  validates :name,  presence: true, uniqueness: true
  validates :price, :picture, presence: true
  validate :picture_size
  validate :neg_price


    # //Search Helpers
  def self.search(param)
      param.strip!
      to_send_back = (id_matches(param) + name_matches(param) + price_matches(param)).uniq
      return nil unless to_send_back
      to_send_back
  end

  def self.id_matches(param)
    matches('id', param)
  end

  def self.name_matches(param)
    matches('name', param)
  end

  def self.price_matches(param)
    matches('price', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%" )
  end

  # //search helper ends

  
  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5 MB")
    end
  end

  def neg_price
    if price < 1
      errors.add(:price, "can't be negative or zero")
    end
  end

end