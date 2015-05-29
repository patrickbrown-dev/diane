defmodule Diane.Atom do
  import SweetXml
  use Timex

  @spec parse(String) :: {:ok, map} | {:error, RuntimeError}
  def parse(source) do
    try do
      parsed = source
      |> parse_header
      |> Map.merge(%{ entries: parse_entries(source) })
      {:ok, parsed}
    rescue
      e in RuntimeError -> {:error, e}
    end
  end

  @spec parse_header(String) :: map
  def parse_header(source) do
    source
    |> xmap(
      title: ~x"//feed/title/text()",
      link: ~x"//feed/link/@href",
      id: ~x"//feed/id/text()",
      updated: ~x"//feed/updated/text()"
    )
  end

  @spec parse_entries(String) :: map
  def parse_entries(source) do
    source
    |> xpath(
      ~x"//feed/entry"l,
      title: ~x"./title/text()",
      link: ~x"./link/@href",
      id: ~x"./id/text()",
      updated: ~x"./updated/text()",
      summary: ~x"./summary/text()"l,
      content: ~x"./content/text()"l
    )
    |> Enum.map(fn(x)-> flatten_fields(x) end)
  end

  # Because xmerl (and by extension, SweetXml) has strange behavior
  # when parsing  & signs in '&amp;quot;' we have to further
  # manipulate the data here. Xmerl, when it encounters the double-
  # nested HTML escaping, will break out the string into an array
  # so we'll have to rejoin them.
  @spec flatten_fields(map) :: map
  defp flatten_fields(entry) do
    %{
      title: entry.title,
      link: entry.link,
      id: entry.id,
      updated: entry.updated,
      summary: Enum.join(entry.summary),
      content: Enum.join(entry.content)
    }
  end
end
