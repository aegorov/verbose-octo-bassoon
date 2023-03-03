# frozen_string_literal: true

# every rules['count'] of item must have 100 discount

class Discounters
  class EveryCountFree < Base
    def valid?
      rules && rules['count'] > 1
    end

    def discount_for(items)
      total_discount = 0
      discountable_items(items).each_with_index do |item, index|
        total_discount += item.price_cents if ((index + 1) % rules['count']).zero?
      end

      total_discount
    end
  end
end
