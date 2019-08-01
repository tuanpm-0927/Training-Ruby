class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  scope :feed_by_id, -> (_user_id) { where(user_id: _user_id) }
  validate :picture_size
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.size_content }

  private
    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > Settings.MG_MAX.megabytes
        errors.add(:picture, t(".error_size_image"))
      end
    end
end
