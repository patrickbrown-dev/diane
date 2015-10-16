defmodule Diane.RSS.ChannelTest do
  use ExUnit.Case, async: true

  @rss_file "test/fixtures/rss.xml"

  def channel do
    @rss_file
    |> File.read!
    |> Diane.RSS.parse!
    |> Map.fetch!(:channels)
    |> List.first
  end

  test "it contains the channel title" do
    assert channel.title == 'xkcd.com'
  end

  test "it contains the channel description" do
    assert channel.description == 'xkcd.com: A webcomic of romance and math humor.'
  end

  test "it contains the channel language" do
    assert channel.language == 'en'
  end

  test "it contains the channel link" do
    assert channel.link == 'http://xkcd.com/'
  end

  test "it contains the channel-level categories" do
    assert channel.categories == ['fib', 'baz']
  end

  test "it contains the cloud information" do
    assert channel.cloud == %{ domain: 'rpc.sys.com',
                               port: '80',
                               path: '/RPC2',
                               register_procedure: 'myCloud.rssPleaseNotify',
                               protocol: 'xml-rpc' }
  end

  test "it contains image element with metadata" do
    assert channel.image == %{ url: 'foo',
                               title: 'bar',
                               link: 'baz',
                               width: '50',
                               height: '150',
                               description: 'Cool image!' }
  end

  test "it contains textInput element" do
    assert channel.text_input == %{ title: 'foo',
                                    description: 'bar',
                                    name: 'baz',
                                    link: 'http://foo.bar/baz' }
  end

  test "it contains all items in channel" do
    assert channel |> Map.fetch!(:items) |> length == 2
  end
end
