class AgedBrie

  def initialize(item)
    @item = item
  end

# quality needs to increase twice as fast after sell-in date has passed!
  def update
    unless @item.quality == 50
      @item.quality += 1
    end
    @item.sell_in -= 1
  end
end
