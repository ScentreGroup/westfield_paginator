RSpec.describe Westfield::PaginatorMeta do
  let(:page) { 1 }
  let(:per_page) { 15 }
  let(:data) { double(:data, current_page: 1, total_pages: 10, per_page: 17, total_count: 120) }

  describe '#as_json' do
    it 'should return the correct details' do
      result =
      {
         page: 1,
         per_page: 17,
         page_count: 10,
         total: 120
       }
      expect(described_class.new(data).as_json).to eql(result)
    end
  end
end
