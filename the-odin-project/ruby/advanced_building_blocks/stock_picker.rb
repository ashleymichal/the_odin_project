## Improved

def stock_picker(price_each_day)
  if price_each_day == price_each_day.sort.reverse
    return "Do not buy!"
  end
  remaining_prices = price_each_day.sort
  best_profit = 0
  while remaining_prices.size > 0
    high = remaining_prices.pop
    sell_day = price_each_day.rindex(high)
    # we don't care about after the highest price, so we slice it off
    slice = price_each_day[0..sell_day]
    low  = slice.min
    buy_day  = price_each_day.index(low)
    if (high - low) > best_profit
      best_profit = (high - low)
      best_days = [buy_day, sell_day]
    end
  end
  best_days
end

puts stock_picker([17,3,6,9,15,8,6,1,17])