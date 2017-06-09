require 'active_support'
require 'active_support/core_ext'

module Westfield
  class PageInfo
    attr_reader :page, :per_page

    # max_per_page is a caller-friendly way to set a cap on the maximum
    # number of results. Otherwise, the caller would have to say:
    # "per_page: [(params[:per_page] || 10), 10].min"
    def initialize(page: nil, per_page: nil, max_per_page: nil)
      # initialize to the default value on nil or ""
      page = 1 if page.blank?

      # initialize to the default value on nil or ""
      per_page = Westfield::Paginator.config.default_per_page if per_page.blank?

      # initialize to the default value on nil or ""
      max_per_page = Westfield::Paginator.config.max_per_page if max_per_page.blank?

      @per_page = [per_page.to_i, max_per_page].min
      @page = page
    end
  end
end
