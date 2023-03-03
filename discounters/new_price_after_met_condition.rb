# frozen_string_literal: true

# rules['new_price_cents'] - the new price of item after condition met
# rules['condition'] - now only supports required coindition, but can be easily expanded

class Discounters
  class NewPriceAfterMetCondition < Base
    def valid?
      rules && rules['new_price_cents'].positive? && rules['condition'] && (rules['condition']['required']).positive?
    end

    def discount_for(items)
      items = discountable_items(items)
      return 0 if items.size < rules['condition']['required']

      items.sum { |item| item.price_cents - rules['new_price_cents'] }
    end
  end
end
