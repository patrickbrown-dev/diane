defmodule Diane.RSS.Item do
  import SweetXml
  defstruct title: String,
            link: String,
            description: String,
            author: String,
            # TODO: category
            comments: String,
            # TODO: enclosure
            guid: String,
            pub_date: String,
            source: String

  def parse(xml) do
    %Diane.RSS.Item {
      title:       xml |> xpath(~x"./title/text()"),
      link:        xml |> xpath(~x"./link/text()"),
      description: xml |> xpath(~x"./description/text()"l) |> Enum.join,
      author:      xml |> xpath(~x"./author/text()"),
      comments:    xml |> xpath(~x"./comments/text()"),
      guid:        xml |> xpath(~x"./guid/text()"),
      pub_date:    xml |> xpath(~x"./pubDate/text()"),
      source:      xml |> xpath(~x"./source/text()")
    }
  end
end
