defmodule Diane.RSS.ItemTest do
  use ExUnit.Case, async: true

  @rss_file "test/fixtures/rss.xml"

  def item do
    @rss_file
    |> File.read!
    |> Diane.RSS.parse!
    |> Map.fetch!(:channels)
    |> List.first
    |> Map.fetch!(:items)
    |> List.first
  end

  test "it can parse the item bodies" do
    assert item.guid == 'http://xkcd.com/1530/'
  end

  test "it contains the item link" do
    assert item.link == 'http://xkcd.com/1530/'
  end

  test "it contains the item pub_date" do
    assert item.pub_date == 'Wed, 27 May 2015 04:00:00 -0000'
  end

  test "it contains the item title" do
    assert item.title == 'Keyboard Mash'
  end

  test "it contains all item categories" do
    assert item.categories == ['foo', 'bar']
  end

  test "it contains the item description" do
    assert item.description == "<img src=\"http://imgs.xkcd.com/comics/keyboard_mash.png\" title=\"WHY DON'T YOU COME HANG OUT INSIDE MY HOUSE. WE CAN COOK BREAD AND CHAT ABOUT OUR INTERNAL SKELETONS.\" alt=\"WHY DON'T YOU COME HANG OUT INSIDE MY HOUSE. WE CAN COOK BREAD AND CHAT ABOUT OUR INTERNAL SKELETONS.\" />"
  end

  test "it contains item enclosures" do
    assert item.enclosure == %{ url: 'http://www.scripting.com/mp3s/weatherReportSuite.mp3',
                                length: '12216320',
                                type: 'audio/mpeg' }
  end
end
