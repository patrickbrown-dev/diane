defmodule Diane do
  @doc """
  Parses an ATOM or RSS file and returns an Elixir map.
  """
  def parse(source) do
    case Diane.Util.determine_format(source) do
      {:ok, :atom}  -> Diane.Atom.parse(source)
      {:ok, :rss}   -> Diane.RSS.parse(source)
      {:error, msg} -> {:error, msg}
    end
  end

  def parse!(source) do
    case Diane.Util.determine_format(source) do
      {:ok, :atom}  -> Diane.Atom.parse!(source)
      {:ok, :rss}   -> Diane.RSS.parse!(source)
      {:error, msg} -> {:error, msg}
    end
  end
end
