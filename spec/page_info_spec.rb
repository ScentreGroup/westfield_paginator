RSpec.describe Westfield::PageInfo do
  let(:page) { 1 }
  let(:per_page) { 1 }
  let(:max_per_page) { nil }
  let(:paginator) do
    described_class.new(page: page, per_page: per_page, max_per_page: max_per_page)
  end

  describe '#initialize' do
    context 'when a page parameter is provided' do
      let(:page) { 2 }

      it 'assigns the page value to the page parameter provided' do
        expect(paginator.page).to eql(2)
      end
    end

    context 'when a page parameter is not provided' do
      let(:page) { nil }

      it 'assigns the page value to the default value' do
        expect(paginator.page).to eql(1)
      end
    end

    context 'when a per_page parameter is provided' do
      let(:per_page) { 20 }

      it 'assigns the per_page value to the per_page parameter provided' do
        expect(paginator.per_page).to eql(20)
      end

      context 'and a max_per_page parameter is provided' do
        context 'and the max_per_page parameter is less than the per_page value' do
          let(:max_per_page) { 5 }

          it 'assigns the per_page value to the max_per_page value' do
            expect(paginator.per_page).to eql(5)
          end
        end

        context 'and the max_per_page parameter is greater than the per_page value' do
          let(:max_per_page) { 500 }

          it 'assigns the per_page value to the given per_page value' do
            expect(paginator.per_page).to eql(20)
          end
        end
      end

      context 'and the per_page parameter value is greater than the default max_per_page' do
        context 'and a max_per_page parameter is not provided' do
          let(:per_page) { 200 }

          it 'assigns the max_per_page value to the default max_per_page value' do
            expect(paginator.per_page).to eql(Westfield::Paginator.config.max_per_page)
          end
        end
      end
    end
  end

end
