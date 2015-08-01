defmodule Diane.RSS do
  import SweetXml
  defstruct channels: [%Diane.RSS.Channel{}]

  def parse(source) do
    try do
      {:ok, parse!(source)}
    rescue
      e in RuntimeError -> {:error, e.message}
      e in CaseClauseError -> {:error, e.message}
      _ -> {:error, "Unknown error occurred"}
    end
  end

  def parse!(source) do
    try do
      case %Diane.RSS{ channels: source
                       |> xpath(~x"//rss/channel"l)
                       |> delegate_to_channel } do
        %Diane.RSS{channels: []} -> raise "Parse error, no channels found"
        rss -> rss
      end
    catch
      :exit, reason -> raise reason
    end
  end

  defp delegate_to_channel(channels) do
    channels |> Enum.map fn channel -> Diane.RSS.Channel.parse(channel) end
  end
end
