class Page < ApplicationRecord
  # before_validation :make_slug
  belongs_to :user
  validates :author, presence: true
  validates :publisher, presence: true
  validates :publisher_url, presence: true
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(created_at: :desc) }
  scope :by_term,  ->(term) do
    term.gsub!(/[^-\w 　]/, '')
    terms = term.match(/[ 　]/) ? term.split(/\s|　/) : [term]

    pages = Page
    terms.each do |t|
      pages = pages.where('content ILIKE ?', "%#{t}%")
    end
    return pages
  end

  scope :by_year_month, ->(year, month) do
    sql = <<-SQL
     extract(year from created_at) = ?
     AND
     extract (month from created_at) = ?
     SQL
    where(sql, year, month)
  end
  def self.month_year_list
    sql = <<-SQL
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
