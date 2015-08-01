defmodule Diane.Util do
  @doc """
  Determines whether source string is an ATOM or RSS feed.
  """

  def determine_format(source) do
    atom_match = Regex.match?(~r/http:\/\/www.w3.org\/2005\/Atom/m, source)
    rss_match = Regex.match?(~r/<rss.*version=.2\.0.*>/m, source)
    case [atom_match, rss_match] do
      [true, false] -> {:ok, :atom}
      [false, true] -> {:ok, :rss}
      _             -> {:error, "Unrecognized format"}
    end
  end
end
