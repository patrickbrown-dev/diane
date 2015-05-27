defmodule Diane.Util do
  @doc """
  Determines whether source string is an ATOM or RSS feed.
  """
  @spec determine_format(String) :: {:ok, Atom} | {:error, String}
  def determine_format(source) do
    case Regex.match?(~r/http:\/\/www.w3.org\/2005\/Atom/m, source) do
      true  -> {:ok, :atom}
      false -> {:error, "Unrecognized format"}
    end
  end
end
