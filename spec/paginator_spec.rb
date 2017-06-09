RSpec.describe Westfield::Paginator do
  let(:elements) { "abcdefghijklmnopqrstuvwxyz".chars }
  let(:expected_meta_keys) {[
    :page, :per_page, :page_count, :total
  ]}

  context 'when a page or per_page value is given' do
    it "returns expected number of items per page" do
      paginator = described_class.new(elements, page: 2, per_page: 3)

      expect(paginator.paginated_records).to match_array(%w(d e f))
    end

    it "returns correct meta information" do
      paginator = described_class.new(elements, page: 2, per_page: 3)

      expect(paginator.meta.keys).to match_array(expected_meta_keys)
      expect(paginator.meta).to include(page: 2)
      expect(paginator.meta).to include(per_page: 3)
      expect(paginator.meta).to include(page_count: 9)
      expect(paginator.meta).to include(total: 26)
    end

    it "applies max_per_page" do
      paginator = described_class.new(elements, page: 2, per_page: 10, max_per_page: 4)

      expect(paginator.meta.keys).to match_array(expected_meta_keys)
      expect(paginator.meta).to include(page: 2)
      expect(paginator.meta).to include(per_page: 4)
      expect(paginator.meta).to include(page_count: 7)
      expect(paginator.meta).to include(total: 26)
    end

    context "and the default values have been overridden via a config block" do
      it "uses the values specified in the parameters" do
        Westfield::Paginator.configure { |c| c.default_per_page = 17 }
        paginator = described_class.new(elements, per_page: 7)

        expect(paginator.meta).to include(per_page: 7)

        Westfield::Paginator.configure { |c| c.default_per_page = GEM_DEFAULT_PER_PAGE }
      end
    end
  end

  context 'when no page or per_page parameters have been given' do
    it "returns correct meta information on nils" do
      paginator = described_class.new(elements)

      expect(paginator.meta.keys).to match_array(expected_meta_keys)
      expect(paginator.meta).to include(page: 1)
      expect(paginator.meta[:per_page]).not_to be_nil
      expect(paginator.meta[:page_count]).not_to be_nil
      expect(paginator.meta[:total]).not_to be_nil
    end

    it "returns correct meta information on \"\"" do
      paginator = described_class.new(elements, page: '', per_page: '')

      expect(paginator.meta.keys).to match_array(expected_meta_keys)
      expect(paginator.meta).to include(page: 1)
      expect(paginator.meta[:per_page]).not_to be_nil
      expect(paginator.meta[:page_count]).not_to be_nil
      expect(paginator.meta[:total]).not_to be_nil
    end

    context "and the default values have been overridden via a config block" do
      it "uses the default values from the config block" do
        Westfield::Paginator.configure { |c| c.default_per_page = 17 }
        paginator = described_class.new(elements)

        expect(paginator.meta).to include(per_page: 17)

        Westfield::Paginator.configure { |c| c.default_per_page = GEM_DEFAULT_PER_PAGE }
      end
    end
  end
end
