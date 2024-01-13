class Page < ApplicationRecord
  attr_accessor :tags_string

  after_save :update_tags
  # before_validation :make_slug
  belongs_to :user
  has_many :page_tags, dependent: :destroy
  has_many :tags, through: :page_tags
  validates :author, presence: true
  validates :publisher, presence: true
  validates :publisher_url, presence: true
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(created_at: :desc) }
  scope :by_term, lambda { |term|
    term.gsub!(/[^-\w 　]/, '')
    terms = term.match(/[ 　]/) ? term.split(/\s|　/) : [term]

    pages = Page
    terms.each do |t|
      pages = pages.where('content ILIKE ?', "%#{t}%")
    end
    return pages
  }

  scope :by_year_month, lambda { |year, month|
    sql = <<-SQL.squish
     extract(year from created_at) = ?
     AND
     extract (month from created_at) = ?
    SQL
    where(sql, year, month)
  }
  def self.month_year_list
    sql = <<-SQL.squish
      SELECT DISTINCT
        TRIM(TO_CHAR(created_at, 'Month')) AS month_name,
        TO_CHAR(created_at, 'MM') AS month_number,
        TO_CHAR(created_at, 'YYYY') AS year
      FROM pages
      WHERE published = true
      ORDER BY year DESC, month_number DESC
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  private

  def update_tags
    self.tags = []
    return if tags_string.blank?

    tags_string.split(',').each do |name|
      name = name
             .downcase
             .gsub(/[_ ]/, '-')
             .gsub(/[^-a-z0-9+]/, '')
             .gsub(/-{2,}/, '-')
             .gsub(/^-/, '')
             .chomp('-')

      tags << Tag.find_or_create_by(name:)
    end
  end
  # def make_slug
  #   return if title.nil?
  #
  #   self.slug = title
  #               .downcase
  #               .gsub(/[_ ]/, '-')
  #               .gsub(/[^-a-z0-9+]/, '')
  #               .gsub(/-{2,}/, '-')
  #               .gsub(/^-/, '')
  #               .chomp('-')
  # end
end
