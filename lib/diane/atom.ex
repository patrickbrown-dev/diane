defmodule Diane.Atom do
  import SweetXml
  use Timex

  @spec parse(String) :: {:ok, map} | {:error, RuntimeError}
  def parse(source) do
    try do
      parsed = source
      |> parse_header
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
      updated: ~x"//feed/updated/text()",
      entries: [
        ~x"//feed/entry"l,
        title: ~x"./title/text()",
        link: ~x"./link/@href",
        id: ~x"./id/text()",
        updated: ~x"./updated/text()",
        published: ~x"./published/text()",
        summary: ~x"./summary/text()",
        content: ~x"./content/text()",
        authors: [
          ~x"./author"l,
          name: ~x"./name/text()",
          uri: ~x"./uri/text()",
          email: ~x"./email/text()"
        ]
      ]
    )
  end
end
