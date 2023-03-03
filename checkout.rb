# frozen_string_literal: true

require_relative 'item'
Dir[File.join(__dir__, 'discounters', '*.rb')].sort.each { |file| require_relative file }
require 'json'

class InvalidPrice < StandardError; end

class Checkout
  def initialize(price_list_path, discounters_list_path)
    @price_list_path = price_list_path
    @discounters_list_path = discounters_list_path
    @items = []
  end

  def scan(item_code)
    new_item = price_list.find { |item| item['code'] == item_code }
    @items << new_item if new_item
  end

  def total
    calculated_price_cents = @items.sum(&:price_cents) - total_discount_cents

    raise InvalidPrice, 'Price is not correct' if @items.any? && !calculated_price_cents.positive?

    calculated_price_cents / 100.0 # simple converting from price_cents to price in EUR
  end

  private

  def total_discount_cents
    discounters.sum do |discounter|
      discounter.discount_for(@items)
    end
  end

  def price_list
    @price_list ||= JSON.parse(File.read(@price_list_path), object_class: Item)
  end

  def discounters
    @discounters ||= JSON.parse(File.read(@discounters_list_path)).map do |discounter|
      Object.const_get("Discounters::#{discounter['type']}").new(discounter)
    rescue NameError
      nil
    end.compact.select(&:valid?)
  end
end
