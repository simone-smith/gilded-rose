require 'gilded_rose'

describe GildedRose do

  before(:each) do
    @dexterity_vest = Item.new("+5 Dexterity Vest", 10, 20)
    @aged_brie = Item.new("Aged Brie", 2, 0)
    @elixir = Item.new("Elixir of the Mongoose", 5, 7)
    @sulfuras1 = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @sulfuras2 = Item.new("Sulfuras, Hand of Ragnaros", -1, 80)
    @backstage_passes1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @backstage_passes2 = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)
    @backstage_passes3 = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)

    @gilded_rose = GildedRose.new([@dexterity_vest, @aged_brie, @elixir, @sulfuras1, @sulfuras2, @backstage_passes1, @backstage_passes2, @backstage_passes3])
  end

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "does not change the sell-in or quality of Sulfuras" do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[3].sell_in).to eq 0
      expect(@gilded_rose.items[3].quality).to eq 80
      expect(@gilded_rose.items[4].sell_in).to eq -1
      expect(@gilded_rose.items[4].quality).to eq 80
    end

    it "increases the quality of Aged Brie by 1" do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[1].quality).to eq 1
    end

    it "decreases the sell-in value of Aged Brie by 1" do
      @gilded_rose.update_quality
      expect(@gilded_rose.items[1].sell_in).to eq 1
    end

  end

end

items = [Item.new("Aged Brie", 2, 3)]
