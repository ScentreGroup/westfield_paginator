RSpec.describe Westfield::Paginator do
  describe 'default_per_page' do
    it 'by default' do
      expect(described_class.config.default_per_page).to eq(GEM_DEFAULT_PER_PAGE)
    end

    it 'configured via config block' do
      new_per_page = GEM_DEFAULT_PER_PAGE + 7
      described_class.configure { |c| c.default_per_page = new_per_page }

      expect(described_class.config.default_per_page).to eq(new_per_page)

      described_class.configure { |c| c.default_per_page = GEM_DEFAULT_PER_PAGE }
    end
  end

  describe 'max_per_page' do
    it 'by default' do
      expect(described_class.config.max_per_page).to eq(GEM_MAX_PER_PAGE)
    end

    it 'configured via config block' do
      new_max_per_page = GEM_MAX_PER_PAGE + 100
      described_class.configure { |c| c.max_per_page = new_max_per_page }

      expect(described_class.config.max_per_page).to eq(new_max_per_page)

      described_class.configure { |c| c.max_per_page = GEM_MAX_PER_PAGE }
    end
  end
end
