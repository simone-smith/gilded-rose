require_relative 'aged_brie'
require_relative 'sulfuras'
require_relative 'backstage_passes'

class GildedRose

  SPECIAL_ITEMS = {
    "Sulfuras, Hand of Ragnaros" => Sulfuras,
    "Aged Brie" => AgedBrie,
    "Backstage passes to a TAFKAL80ETC concert" => BackstagePasses
  }

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def check_item
    @items.each do |item|
      if SPECIAL_ITEMS[item.name]
        SPECIAL_ITEMS[item.name].new(item).update_quality
      else
        update_quality(item)
      end
    end
  end

  def update_quality(item)
    if item.sell_in > 0
      unless item.quality == 0
        item.quality -= 1
      end
      item.sell_in -= 1
    else
      unless item.quality <= 1
        item.quality -= 2
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
