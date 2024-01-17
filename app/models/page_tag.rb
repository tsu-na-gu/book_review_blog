class PageTag < ApplicationRecord
  belongs_to :page
  belongs_to :tag, counter_cache: true
  validates :tag_id, uniqueness: { scope: :page_id }

  def self.ransackable_attributes(auth_object = nil)
    super
  end

  def self.ransackable_associations(auth_object = nil)
    super
  end
end
