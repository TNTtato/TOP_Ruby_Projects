def stock_picker(prices)
  hash_diff = set_diff(prices)
  return [] if hash_diff.empty?
  hash_diff.key(hash_diff.values.max)
end

def set_diff(prices)
  hash_result = Hash.new(0)
  prices.each_with_index do |price_i, i|
    next_days_prices = prices[i + 1..-1]
    next_days_prices.each_with_index do |price_j, j|
      j += i + 1
      position = [i, j]
      hash_result[position] = price_j - price_i if j > i && price_j > price_i
    end
  end
  hash_result 
end


p stock_picker([17,3,6,9,15,8,6,1,10])
p stock_picker([10,9,8,7,6,5,4,3,2,1])
p stock_picker([10,9,8,7,6,5,4,3,1,2])
p stock_picker([15,3,14,1,13,1])
