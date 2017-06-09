module Westfield
  class PaginatorMeta
    def initialize(paginator)
      @paginator = paginator
    end

    def as_json
      {
        page:        paginator.current_page,
        per_page:    paginator.per_page,
        page_count:  paginator.total_pages,
        total:       paginator.total_count
      }
    end

    private
    attr_reader :paginator
  end
end
