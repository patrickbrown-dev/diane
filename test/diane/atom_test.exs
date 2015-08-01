defmodule Diane.AtomTest do
  use ExUnit.Case, async: true
  import Diane.Atom

  @atom_file "test/fixtures/atom.xml"

  test "it can properly parse an atom file" do
    {:ok, source} = File.read(@atom_file)

    assert parse(source) == {:ok, %{
      title: 'xkcd.com',
      link: 'http://xkcd.com/',
      id: 'http://xkcd.com/',
      updated: '2015-05-27T00:00:00Z',
      entries: [
        %{ id:      'http://xkcd.com/1530/',
           title:   'Keyboard Mash',
           link:    'http://xkcd.com/1530/',
           updated: '2015-05-27T00:00:00Z',
           published: nil,
           authors: [%{ name: 'Randall Monroe',
                        uri: 'http://xkcd.com',
                        email: 'randall@xkcd.com' }],
           summary: '<img src="http://imgs.xkcd.com/comics/keyboard_mash.png" title="WHY DON\'T YOU COME HANG OUT INSIDE MY HOUSE. WE CAN COOK BREAD AND CHAT ABOUT OUR INTERNAL SKELETONS." alt="WHY DON\'T YOU COME HANG OUT INSIDE MY HOUSE. WE CAN COOK BREAD AND CHAT ABOUT OUR INTERNAL SKELETONS." />',
           content: nil },
      ]
    }}
  end
end
