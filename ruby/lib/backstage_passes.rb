require 'pry'

class BackstagePasses

  def initialize(item)
    @item = item
  end

  def update
    update_quality
    update_sell_in
  end

  private
  def update_quality
    if @item.sell_in <= 5
      @item.quality += 3
    elsif @item.sell_in <= 10
      @item.quality += 2
    else
      @item.quality += 1
    end
    @item.quality = 0 if @item.sell_in < 1
    @item.quality = 50 if @item.quality > 50
  end

  def update_sell_in
    @item.sell_in -= 1
  end

end
