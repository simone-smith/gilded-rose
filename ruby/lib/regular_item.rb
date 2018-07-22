class RegularItem
  def initialize(item)
    @item = item
  end

  def update_quality
    if @item.sell_in > 0
      unless @item.quality == 0
        @item.quality -= 1
      end
      @item.sell_in -= 1
    else
      unless @item.quality <= 1
        @item.quality -= 2
      end
    end
  end
end
