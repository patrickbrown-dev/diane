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
