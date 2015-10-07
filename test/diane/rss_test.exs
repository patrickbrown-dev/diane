defmodule Diane.RSSTest do
  use ExUnit.Case, async: true
  import Diane.RSS

  @rss_file "test/fixtures/rss.xml"

  def parsed_source do
    @rss_file |> File.read! |> parse!
  end

  test "it contains all channels in feed" do
    assert parsed_source.channels |> length == 1
  end

  test "it contains the channel title" do
    channel = parsed_source.channels |> List.first
    assert channel.title == 'xkcd.com'
  end

  test "it contains the channel description" do
    channel = parsed_source.channels |> List.first
    assert channel.description == 'xkcd.com: A webcomic of romance and math humor.'
  end

  test "it contains the channel language" do
    channel = parsed_source.channels |> List.first
    assert channel.language == 'en'
  end

  test "it contains the channel link" do
    channel = parsed_source.channels |> List.first
    assert channel.link == 'http://xkcd.com/'
  end

  test "it contains the channel-level categories" do
    channel = parsed_source.channels |> List.first
    assert channel.categories == ['fib', 'baz']
  end

  test "it contains the cloud information" do
    channel = parsed_source.channels |> List.first
    assert channel.cloud == %{ domain: 'rpc.sys.com',
                               port: '80',
                               path: '/RPC2',
                               register_procedure: 'myCloud.rssPleaseNotify',
                               protocol: 'xml-rpc' }
  end

  test "it contains image element with metadata" do
    channel = parsed_source.channels |> List.first
    assert channel.image == %{ url: 'foo',
                               title: 'bar',
                               link: 'baz',
                               width: '50',
                               height: '150',
                               description: 'Cool image!' }
  end

  test "it contains all items in channel" do
    item_count = parsed_source.channels
    |> List.first
    |> Map.fetch!(:items)
    |> length

    assert item_count == 2
  end

  test "it can parse the item bodies" do
    item = parsed_source.channels
    |> List.first
    |> Map.fetch!(:items)
    |> List.first
    assert item.guid == 'http://xkcd.com/1530/'
  end

  test "it contains the item link" do
    item = parsed_source.channels
    |> List.first
    |> Map.fetch!(:items)
    |> List.first
    assert item.link == 'http://xkcd.com/1530/'
  end

  test "it contains the item pub_date" do
    item = parsed_source.channels
    |> List.first
    |> Map.fetch!(:items)
    |> List.first
    assert item.pub_date == 'Wed, 27 May 2015 04:00:00 -0000'
  end

  test "it contains the item title" do
    item = parsed_source.channels
    |> List.first
    |> Map.fetch!(:items)
    |> List.first
    assert item.title == 'Keyboard Mash'
  end

  test "it contains all item categories" do
    item = parsed_source.channels
    |> List.first
    |> Map.fetch!(:items)
    |> List.first
    assert item.categories == ['foo', 'bar']
  end

  test "it contains the item description" do
    item = parsed_source.channels
    |> List.first
    |> Map.fetch!(:items)
    |> List.first
    assert item.description == "<img src=\"http://imgs.xkcd.com/comics/keyboard_mash.png\" title=\"WHY DON'T YOU COME HANG OUT INSIDE MY HOUSE. WE CAN COOK BREAD AND CHAT ABOUT OUR INTERNAL SKELETONS.\" alt=\"WHY DON'T YOU COME HANG OUT INSIDE MY HOUSE. WE CAN COOK BREAD AND CHAT ABOUT OUR INTERNAL SKELETONS.\" />"
  end

  test "it raises an error when no channels are found" do
    atom_file = "test/fixtures/atom.xml" |> File.read!
    assert_raise RuntimeError, "Parse error, no channels found", fn ->
      parse! atom_file
    end
  end

  test "parse equivalent catches error and puts it into error tuple" do
    atom_file = "test/fixtures/atom.xml" |> File.read!
    assert parse(atom_file) == {:error, "Parse error, no channels found"}
  end

  test "it raises an error when file isn't a valid xml file" do
    not_xml = "this is definitely not xml"
    assert_raise RuntimeError, fn ->
      parse! not_xml
    end
  end

  test "parse equivalent catches error and puts it into error tuple" do
    not_xml = "this is definitely not xml"
    assert parse(not_xml) == {:error, "Unknown error occurred"}
  end
end
