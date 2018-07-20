class AgedBrie

  def initialize(item)
    @item = item
  end

  def update_quality
    unless @item.quality == 50
      @item.quality += 1
    end
    @item.sell_in -= 1
  end
end
