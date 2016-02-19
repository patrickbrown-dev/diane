defmodule Diane.RSS.Item do
  import SweetXml

  defstruct [
    :title,
    :link,
    :description,
    :author,
    :categories,
    :comments,
    :enclosure,
    :guid,
    :pub_date,
    :source
  ]

  def parse(xml) do
    %Diane.RSS.Item {
      title:       xml |> xpath(~x"./title/text()"),
      link:        xml |> xpath(~x"./link/text()"),
      description: xml |> xpath(~x"./description/text()"l) |> Enum.join,
      author:      xml |> xpath(~x"./author/text()"),
      categories:  xml |> xpath(~x"./category/text()"l),
      comments:    xml |> xpath(~x"./comments/text()"),
      enclosure:   xml |> xpath(~x"./enclosure") |> parse_enclosure,
      guid:        xml |> xpath(~x"./guid/text()"),
      pub_date:    xml |> xpath(~x"./pubDate/text()"),
      source:      xml |> xpath(~x"./source/text()")
    }
  end

  defp parse_enclosure(nil), do: %{}
  defp parse_enclosure(xml) do
    %{
      url:    xml |> xpath(~x"./@url"),
      length: xml |> xpath(~x"./@length"),
      type:   xml |> xpath(~x"./@type")
    }
  end
end
