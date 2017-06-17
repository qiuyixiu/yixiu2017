class Product < ApplicationRecord
  validates :price, presence: true

  validates_presence_of :title, :friendly_id

  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

  before_validation :generate_friendly_id, :on => :create
  mount_uploader :image, ImageUploader
  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC')}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  has_many :favorites
  has_many :users, through: :favorites, source: :user
  has_many :comments
  belongs_to :category
  has_many :photos
  accepts_nested_attributes_for :photos

  def to_param
    self.friendly_id
  end

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end
end
