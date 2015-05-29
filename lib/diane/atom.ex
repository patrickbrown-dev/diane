defmodule Diane.Atom do
  import SweetXml
  use Timex

  def parse(source) do
    source
    |> parse_header
    |> Map.merge(%{ entries: parse_entries(source) })
  end

  def parse_header(source) do
    source
    |> xmap(
      title: ~x"//feed/title/text()",
      link: ~x"//feed/link/@href",
      updated: ~x"//feed/updated/text()"
    )
  end

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
    |> Enum.map(fn(x)-> flatten_entry_fields(x) end)
  end

  defp flatten_entry_fields(entry) do
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
