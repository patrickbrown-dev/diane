defmodule Diane do
  @doc """
  Parses an ATOM or RSS file and returns a Atom or RSS struct.
  `parse\1` returns a tuple monad indicating failure or succes,
  `parse!\1` raises an exception on error.
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
