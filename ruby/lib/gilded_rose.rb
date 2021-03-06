require_relative 'item'
require_relative 'aged_brie'
require_relative 'sulfuras'
require_relative 'backstage_passes'
require_relative 'conjured'
require_relative 'regular_item'

class GildedRose

  SPECIAL_ITEMS = {
    "Sulfuras, Hand of Ragnaros" => Sulfuras,
    "Aged Brie" => AgedBrie,
    "Backstage passes to a TAFKAL80ETC concert" => BackstagePasses,
    "Conjured" => Conjured
  }

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def check_item
    @items.each do |item|
      if SPECIAL_ITEMS[item.name]
        item = SPECIAL_ITEMS[item.name].new(item)
      else
        item = RegularItem.new(item)
      end
      item.update
    end
  end
end
