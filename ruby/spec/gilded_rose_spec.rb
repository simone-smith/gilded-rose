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

  describe "#check_item" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).check_item
      expect(items[0].name).to eq "foo"
    end

    it "changes the quality according to specific rules for each item" do
      @gilded_rose.check_item
      expect(@gilded_rose.items[0].quality).to eq 19
      expect(@gilded_rose.items[1].quality).to eq 1
      expect(@gilded_rose.items[2].quality).to eq 6
      expect(@gilded_rose.items[3].quality).to eq 80
      expect(@gilded_rose.items[4].quality).to eq 80
      expect(@gilded_rose.items[5].quality).to eq 21
      expect(@gilded_rose.items[6].quality).to eq 51
      expect(@gilded_rose.items[7].quality).to eq 52
    end

    context "Normal items" do
      it "quality decreases by 1 each day" do
        @gilded_rose.check_item
        expect(@gilded_rose.items[0].quality).to eq 19
      end

      it "sell-in decreases by 1 each day" do
        @gilded_rose.check_item
        expect(@gilded_rose.items[0].sell_in).to eq 9
      end

      it "quality decreases twice as fast when sell-in is less than or equal to 0" do
        11.times { @gilded_rose.check_item }
        expect(@gilded_rose.items[0].quality).to eq 8
      end

      it "quality never drops below 0" do
        7.times { @gilded_rose.check_item }
        expect(@gilded_rose.items[2].quality).to eq 0
      end

      it "quality never rises above 50" do
        51.times { @gilded_rose.check_item }
        expect(@gilded_rose.items[1].quality).to eq 50
      end
    end

    context "Sulfuras" do
      it "does not change the sell-in or quality of Sulfuras" do
        expect(@gilded_rose.items[3].sell_in).to eq 0
        expect(@gilded_rose.items[3].quality).to eq 80
        expect(@gilded_rose.items[4].sell_in).to eq -1
        expect(@gilded_rose.items[4].quality).to eq 80
      end
    end

    context "Aged Brie" do
      it "increases the quality of Aged Brie by 1" do
        @gilded_rose.check_item
        expect(@gilded_rose.items[1].quality).to eq 1
      end

      it "decreases the sell-in value of Aged Brie by 1" do
        @gilded_rose.check_item
        expect(@gilded_rose.items[1].sell_in).to eq 1
      end
    end

    context "Backstage Passes" do
      context "when sell-in value is less than 11" do
        it "quality increases by 3" do
          5.times { @gilded_rose.check_item }
          expect(@gilded_rose.items[5].quality).to eq 25
        end
      end

      context "when sell-in value is less than 6" do
        it "quality increases by 2" do
          10.times { @gilded_rose.check_item }
          expect(@gilded_rose.items[5].quality).to eq 35
        end
      end

      context "when sell-in value is less than 1" do
        it "quality drops to 0" do
          16.times { @gilded_rose.check_item }
          expect(@gilded_rose.items[5].quality).to eq 0
        end
      end
    end
  end

end
