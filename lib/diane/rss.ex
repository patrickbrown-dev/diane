defmodule Diane.RSS do
  import SweetXml
  defstruct channels: [%Diane.RSS.Channel{}]

  def parse(source) do
    %Diane.RSS{
      channels: source |> xpath(~x"//rss/channel"l) |> delegate_to_channel
    }
  end

  defp delegate_to_channel(channels) do
    channels |> Enum.map fn channel -> Diane.RSS.Channel.parse(channel) end
  end
end
