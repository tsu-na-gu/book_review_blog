class Image < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    super
  end
end
