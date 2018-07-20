require 'pry'

class BackstagePasses

  def initialize(item)
    @item = item
  end

  def update_quality
    if @item.sell_in < 1
      @item.quality = 0
      @item.sell_in -= 1
    elsif @item.sell_in <= 5
      @item.quality += 3
      @item.sell_in -= 1
    elsif @item.sell_in <= 10
      @item.quality += 2
      @item.sell_in -= 1
    else
      @item.quality += 1
      @item.sell_in -= 1
    end
  end
end
