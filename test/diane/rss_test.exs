defmodule Diane.RSSTest do
  use ExUnit.Case, async: true
  import Diane.RSS

  @rss_file "test/fixtures/rss.xml"

  test "it can properly parse an atom file" do
    {:ok, source} = File.read(@rss_file)

    expect = %Diane.RSS{
      channels: [
        %Diane.RSS.Channel{
          description: 'xkcd.com: A webcomic of romance and math humor.',
          items: [
            %Diane.RSS.Item{
              link: 'http://xkcd.com/1530/',
              title: 'Keyboard Mash',
              description: "<img src=\"http://imgs.xkcd.com/comics/keyboard_mash.png\" title=\"WHY DON'T YOU COME HANG OUT INSIDE MY HOUSE. WE CAN COOK BREAD AND CHAT ABOUT OUR INTERNAL SKELETONS.\" alt=\"WHY DON'T YOU COME HANG OUT INSIDE MY HOUSE. WE CAN COOK BREAD AND CHAT ABOUT OUR INTERNAL SKELETONS.\" />"
             },
            %Diane.RSS.Item{
              description: "<img src=\"http://imgs.xkcd.com/comics/vodka.png\" title=\"Or whatever's handy! I'm pretty much pure alcohol and water, so it doesn't really matter!\" alt=\"Or whatever's handy! I'm pretty much pure alcohol and water, so it doesn't really matter!\" />",
              link: 'http://xkcd.com/1528/',
              title: 'Vodka'
            }
          ],
          title: 'xkcd.com',
          link: 'http://xkcd.com/'
        }
      ]
    }

    assert parse(source) == {:ok, expect}
  end
end
