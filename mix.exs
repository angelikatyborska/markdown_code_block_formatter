defmodule MarkdownCodeBlockFormatter.MixProject do
  use Mix.Project

  def project do
    [
      app: :markdown_code_block_formatter,
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Markdown Code Block Formatter",
      source_url: "https://github.com/angelikatyborska/markdown_code_block_formatter/",
      description: description(),
      package: package(),
      docs: docs(),
      dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Elixir formatter plugin for formatting Elixir code in Markdown files."
  end

  defp package() do
    [
      name: "markdown_code_block_formatter",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/angelikatyborska/markdown_code_block_formatter",
        "Changelog" =>
          "https://github.com/angelikatyborska/markdown_code_block_formatter/blob/main/CHANGELOG.md"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      assets: "assets",
      extras: [
        "README.md",
        "CHANGELOG.md"
      ]
    ]
  end
end
