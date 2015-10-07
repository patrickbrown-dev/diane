defmodule Diane.RSS.Channel do
  import SweetXml
  defstruct title: String,
            link: String,
            description: String,
            language: String,
            copyright: String,
            managing_editor: String,
            web_master: String,
            pub_date: String,
            last_build_date: String,
            categories: [],
            generator: String,
            docs: String,
            cloud: %{},
            ttl: String,
            # TODO: image
            # TODO: text_input
            skip_hours: String,
            skip_days: String,
            items: [%Diane.RSS.Item{}]

  def parse(xml) do
    %Diane.RSS.Channel {
      title:           xml |> xpath(~x"./title/text()"),
      link:            xml |> xpath(~x"./link/text()"),
      description:     xml |> xpath(~x"./description/text()"),
      language:        xml |> xpath(~x"./language/text()"),
      copyright:       xml |> xpath(~x"./copyright/text()"),
      managing_editor: xml |> xpath(~x"./managingEditor/text()"),
      web_master:      xml |> xpath(~x"./webMaster/text()"),
      pub_date:        xml |> xpath(~x"./pubDate/text()"),
      last_build_date: xml |> xpath(~x"./lastBuildDate/text()"),
      categories:      xml |> xpath(~x"./category/text()"l),
      generator:       xml |> xpath(~x"./generator/text()"),
      docs:            xml |> xpath(~x"./docs/text()"),
      cloud:           xml |> xpath(~x"./cloud") |> parse_cloud,
      ttl:             xml |> xpath(~x"./ttl/text()"),
      skip_hours:      xml |> xpath(~x"./skipHours/text()"),
      skip_days:       xml |> xpath(~x"./skipDays/text()"),
      items:           xml |> xpath(~x"./item"l) |> delegate_to_item
    }
  end

  defp parse_cloud(xml) do
    %{
      domain:              xml |> xpath(~x"./@domain"),
      port:                xml |> xpath(~x"./@port"),
      path:                xml |> xpath(~x"./@path"),
      register_procedure: xml |> xpath(~x"./@registerProcedure"),
      protocol:            xml |> xpath(~x"./@protocol")
    }
  end

  defp delegate_to_item(items) do
    items |> Enum.map fn item -> Diane.RSS.Item.parse(item) end
  end
end
