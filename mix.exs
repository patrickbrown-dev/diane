defmodule Diane.Mixfile do
  use Mix.Project

  def project do
    [app: :diane,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:sweet_xml, "~> 0.2.1"}]
  end

  defp description do
    """
    RSS/Atom parser for Elixir.
    """
  end

  defp package do
    [maintainers: ["Patrick Arthur Brown"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/ptrckbrwn/diane"}]
  end
end
