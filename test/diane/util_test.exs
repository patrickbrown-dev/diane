defmodule Diane.UtilTest do
  use ExUnit.Case, async: true
  import Diane.Util

  @atom_file "test/fixtures/atom.xml"
  @rss_file "test/fixtures/rss.xml"

  test "determine_format can recognize ATOM feeds" do
    {:ok, source} = File.read(@atom_file)
    assert determine_format(source) == {:ok, :atom}
  end

  test "determine_format can recognize RSS feeds" do
    {:ok, source}  = File.read(@rss_file)
    assert determine_format(source) == {:ok, :rss}
  end
end
