## System Requirements
* Ruby

## How to check
 ``` ruby
  irb -I .
  require 'checkout'

  checkout = Checkout.new('data/prices.json', 'data/discounters.json')
  checkout.scan("VOUCHER")
  checkout.scan("VOUCHER")
  checkout.scan("TSHIRT")
  price = checkout.total
```

## Adding new discount logic

If you want to add new discount rules and it does not fit the logic to `Discounters::EveryCountFree`, `Discounters:: NewPriceAfterMetCondition`, add new in `discounters/folder` with two methods: `valid?` and `discount_for`

```ruby
class Discounters
  class NewDiscounter
    def valid?
     # validate rules field with you logic
    end

    def discount_for(items)
      # calculate discount logic with settings from rules field
    end
  end
end
```

## Running tests

```ruby
gem install rspec
rspec
```

## Additional Questions for product owners
* Is it possible to combine more than one discount per one product?
* Is there max discount for total order price?
