# frozen_string_literal: true

require_relative '../checkout'

RSpec.describe 'Checkout' do
  let(:checkout) { Checkout.new(items_path, discounters_path) }
  let(:items_path) { 'data/prices.json' }
  let(:discounters_path) { 'data/discounters.json' }

  describe '#total' do
    context 'working examples from https://novicap.com/en/code-challenge/' do
      it do
        checkout.scan('VOUCHER')
        checkout.scan('TSHIRT')
        checkout.scan('MUG')

        expect(checkout.total).to eq 32.50
      end

      it do
        checkout.scan('VOUCHER')
        checkout.scan('TSHIRT')
        checkout.scan('VOUCHER')

        expect(checkout.total).to eq 25.00
      end

      it do
        checkout.scan('TSHIRT')
        checkout.scan('TSHIRT')
        checkout.scan('TSHIRT')
        checkout.scan('VOUCHER')
        checkout.scan('TSHIRT')

        expect(checkout.total).to eq 81.00
      end

      it do
        checkout.scan('VOUCHER')
        checkout.scan('TSHIRT')
        checkout.scan('VOUCHER')
        checkout.scan('VOUCHER')
        checkout.scan('MUG')
        checkout.scan('TSHIRT')
        checkout.scan('TSHIRT')

        expect(checkout.total).to eq 74.50
      end
    end

    context 'without any item added' do
      it { expect(checkout.total).to eq 0.0 }
    end

    context 'with invalid discounters' do
      let(:discounters_path) { 'data/invalid_discounters.json' }

      it do
        checkout.scan('VOUCHER')
        checkout.scan('VOUCHER')

        expect(checkout.total).to eq 10.00
      end
    end
  end
end
