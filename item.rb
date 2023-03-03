# frozen_string_literal: true

# Let's imagine, that's now we only operate with EUR, so we don't need to store currency
Item = Struct.new(:code, :name, :price_cents)
