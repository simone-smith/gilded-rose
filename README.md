# Gilded Rose Refactoring Kata

This is my attempt at the Gilded Rose refactoring kata in Ruby, originally created by Terry Hughes (http://twitter.com/TerryHughes). See also [Bobby Johnson's description of the kata](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/).

## Specification

The requirements for the Gilded Rose kata are as follows:

```
======================================
Gilded Rose Requirements Specification
======================================

Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a
prominent city ran by a friendly innkeeper named Allison. We also buy and sell only the finest goods.
Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We
have a system in place that updates our inventory for us. It was developed by a no-nonsense type named
Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that
we can begin selling a new category of items. First an introduction to our system:

	- All items have a SellIn value which denotes the number of days we have to sell the item
	- All items have a Quality value which denotes how valuable the item is
	- At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

	- Once the sell by date has passed, Quality degrades twice as fast
	- The Quality of an item is never negative
	- "Aged Brie" actually increases in Quality the older it gets
	- The Quality of an item is never more than 50
	- "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
	- "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
	Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
	Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

	- "Conjured" items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything
still works correctly. However, do not alter the Item class or Items property as those belong to the
goblin in the corner who will insta-rage and one-shot you as he doesn't believe in shared code
ownership (you can make the UpdateQuality method and Items property static if you like, we'll cover
for you).

Just for clarification, an item can never have its Quality increase above 50, however "Sulfuras" is a
legendary item and as such its Quality is 80 and it never alters.
```

## How I approached designing my solution to the problem

I wrote a set of feature tests to cover all the requirements and ensure that I would be able to refactor safely without introducing any regression errors. When I was satisfied that I had covered all the requirements and had taken edge cases into consideration, I was able to start refactoring the code in the GildedRose class.

## How I structured my code

Rather than having a large set of nested `if` statements in one class, I wanted the GildedRose class to act as a 'master' class that could dynamically ascertain whether the item being updated was a regular item or an exception. It would then delegate to the `update` method in the relevant class, so that the appropriate rules regarding quality degradation/improvement could be applied.

In this way, it is easy to add a new feature to the system, by adding an item to the SPECIAL_ITEMS hash in the GildedRose class, and adding all the logic for the new feature to a separate, new class.

## How to install and run my code and tests

- Clone this repository to your machine
- In the console
  - run `bundle install`
	- run `rspec` to check the tests are passing
	- open `irb` and load the file (require './lib/gilded_rose.rb')

A screenshot of how it works is below:

```
[simonesmith:...ilded-rose/gilded-rose/ruby]$ irb   (master✱)
2.5.0 :001 > require './lib/gilded_rose.rb'
 => true
2.5.0 :002 >   dexterity_vest = Item.new("+5 Dexterity Vest", 10, 20)
 => #<Item:0x00007fe3cc1d4b80 @name="+5 Dexterity Vest", @sell_in=10, @quality=20>
2.5.0 :003 >   aged_brie = Item.new("Aged Brie", 2, 0)
 => #<Item:0x00007fe3cc1bcad0 @name="Aged Brie", @sell_in=2, @quality=0>
2.5.0 :004 >   sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
 => #<Item:0x00007fe3cb98fba0 @name="Sulfuras, Hand of Ragnaros", @sell_in=0, @quality=80>
2.5.0 :005 >   backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
 => #<Item:0x00007fe3cc1a5038 @name="Backstage passes to a TAFKAL80ETC concert", @sell_in=15, @quality=20>
2.5.0 :006 >   conjured = Item.new("Conjured", 3, 6)
 => #<Item:0x00007fe3cc18f058 @name="Conjured", @sell_in=3, @quality=6>
2.5.0 :007 > gilded_rose = GildedRose.new([dexterity_vest, aged_brie, sulfuras, backstage_passes, conjured])
 => #<GildedRose:0x00007fe3cb8fa988 @items=[#<Item:0x00007fe3cc1d4b80 @name="+5 Dexterity Vest", @sell_in=10, @quality=20>, #<Item:0x00007fe3cc1bcad0 @name="Aged Brie", @sell_in=2, @quality=0>, #<Item:0x00007fe3cb98fba0 @name="Sulfuras, Hand of Ragnaros", @sell_in=0, @quality=80>, #<Item:0x00007fe3cc1a5038 @name="Backstage passes to a TAFKAL80ETC concert", @sell_in=15, @quality=20>, #<Item:0x00007fe3cc18f058 @name="Conjured", @sell_in=3, @quality=6>]>
2.5.0 :008 > gilded_rose.check_item
 => [#<Item:0x00007fe3cc1d4b80 @name="+5 Dexterity Vest", @sell_in=9, @quality=19>, #<Item:0x00007fe3cc1bcad0 @name="Aged Brie", @sell_in=1, @quality=1>, #<Item:0x00007fe3cb98fba0 @name="Sulfuras, Hand of Ragnaros", @sell_in=0, @quality=80>, #<Item:0x00007fe3cc1a5038 @name="Backstage passes to a TAFKAL80ETC concert", @sell_in=14, @quality=21>, #<Item:0x00007fe3cc18f058 @name="Conjured", @sell_in=2, @quality=4>]
```

## Test coverage

```
GildedRose
  #check_item
    does not change the name
    changes the quality according to specific rules for each item
    Normal items
      quality decreases by 1 each day
      sell-in decreases by 1 each day
      quality decreases twice as fast when sell-in is less than or equal to 0
      quality never drops below 0
      quality never rises above 50
    Sulfuras
      does not change the sell-in or quality of Sulfuras
    Aged Brie
      increases the quality by 1
      decreases the sell-in value by 1
      increases the quality by 2 after the sell-in date has passed
    Backstage Passes
      quality never rises above 50
      quality never drops below 0
      when sell-in value is less than 11
        quality increases by 3
      when sell-in value is less than 6
        quality increases by 2
      when sell-in value is less than 1
        quality drops to 0
    Conjured
      quality decreases twice as fast as normal items
      quality never drops below 0

Finished in 0.00678 seconds (files took 0.40669 seconds to load)
18 examples, 0 failures


COVERAGE:  99.41% -- 168/169 lines in 8 files
```

```
[simonesmith:...ilded-rose/gilded-rose/ruby]$ rubocop
Inspecting 11 files
...........

11 files inspected, no offenses detected
```

All tests are passing, SimpleCov confirmed that test coverage is 99.41%, and Rubocop detects no offenses.
