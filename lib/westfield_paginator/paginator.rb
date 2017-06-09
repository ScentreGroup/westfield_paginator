require 'kaminari'
require 'kaminari/models/array_extension'

module Westfield
  class Paginator
    def initialize(records, page: nil, per_page: nil, max_per_page: nil)
      @page_info = Westfield::PageInfo.new(page: page, per_page: per_page, max_per_page: max_per_page)

      if records.is_a? Array
        @records = Kaminari.paginate_array(records)
      else
        @records  = records
      end
    end

    def paginated_records
      @paginated ||= @records.page(page_info.page).per(page_info.per_page)
    end

    def meta
      PaginatorMeta.new(self).as_json
    end

    def current_page
      paginated_records.current_page
    end

    def per_page
      page_info.per_page
    end

    def total_pages
      paginated_records.total_pages
    end

    def total_count
      paginated_records.total_count
    end

    private
    attr_reader :page_info
  end
end
