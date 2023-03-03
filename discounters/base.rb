# frozen_string_literal: true

class Discounters
  Base = Struct.new(:item_code, :type, :rules, keyword_init: true) do
    def discount_for(items)
      raise NotImplementedError, 'Method should be implemented'
    end

    def valid?
      raise NotImplementedError, 'Check correct values for rules field for each discounter'
    end

    private

    def discountable_items(items)
      items.select { |item| item.code == item_code }
    end
  end
end
