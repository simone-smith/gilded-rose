class AgedBrie

  def initialize(item)
    @item = item
  end

  def update
    unless @item.quality == 50
      if @item.sell_in > 0
        @item.quality += 1
      else
        @item.quality += 2
      end
    end
    @item.sell_in -= 1
  end
end
