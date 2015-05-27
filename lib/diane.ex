defmodule Diane do
  @doc """
  Parses an ATOM or RSS file and returns an Elixir map.
  """
  @spec parse(String) :: {:ok, map} | {:error, String}
  def parse(source) do
    case Diane.Util.determine_format(source) do
      :atom         -> Diane.Atom.parse(source)
      :rss          -> Diane.RSS.parse(source)
      {:error, msg} -> {:error, msg}
    end
  end
end
