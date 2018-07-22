require 'pry'

class BackstagePasses

  def initialize(item)
    @item = item
  end

# MAKE SURE THE QUALITY CAN'T GO ABOVE 50!!
  def update
      if @item.sell_in < 1
        @item.quality = 0
      elsif @item.sell_in <= 5
        @item.quality += 3
      elsif @item.sell_in <= 10
        @item.quality += 2
      else
        @item.quality += 1
      end
      if @item.quality > 50
        @item.quality = 50
      end
    @item.sell_in -= 1
  end
end
