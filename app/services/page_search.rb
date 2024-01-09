module PageSearch
  def self.search(params)
    return [] if params.blank?

    pages = if params[:year].present? && params[:month].present?
              Page.by_year_month(params[:year].to_i, params[:month].to_i)
            elsif params[:term].present?
              Page.by_term(params[:term])
            end
    return [] unless pages

    return pages.published.ordered
  end
end
