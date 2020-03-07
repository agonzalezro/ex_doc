defmodule ExDoc.Mixfile do
  use Mix.Project

  @version "0.21.3"

  def project do
    [
      app: :ex_doc,
      version: @version,
      elixir: "~> 1.7",
      deps: deps(),
      aliases: aliases(),
      package: package(),
      escript: escript(),
      source_url: "https://github.com/elixir-lang/ex_doc/",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      description: "ExDoc is a documentation generation tool for Elixir",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:eex, :crypto]
    ]
  end

  defp deps do
    [
      {:earmark, "~> 1.4"},
      {:makeup_elixir, "~> 0.14"},
      {:excoveralls, "~> 0.3", only: :test}
    ]
  end

  defp aliases do
    [
      clean: [&clean_test_fixtures/1, "clean"],
      setup: ["deps.get", "cmd npm install"],
      build: ["cmd npm run build", "compile --force", "docs"]
    ]
  end

  defp package do
    [
      licenses: ["Apache 2.0"],
      maintainers: [
        "José Valim",
        "Eksperimental",
        "Milton Mazzarri",
        "Friedel Ziegelmayer",
        "Dmitry"
      ],
      files: ["formatters", "lib", "mix.exs", "LICENSE", "CHANGELOG.md", "README.md"],
      links: %{
        "GitHub" => "https://github.com/elixir-lang/ex_doc",
        "Writing documentation" => "https://hexdocs.pm/elixir/writing-documentation.html"
      }
    ]
  end

  defp escript do
    [
      main_module: ExDoc.CLI
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md",
        "CHANGELOG.md"
      ],
      source_ref: "v#{@version}",
      source_url: "https://github.com/elixir-lang/ex_doc",
      groups_for_modules: [
        Markdown: [
          ExDoc.Markdown,
          ExDoc.Markdown.Earmark
        ],
        "Formatter API": [
          ExDoc.Config,
          ExDoc.Formatter.EPUB,
          ExDoc.Formatter.HTML,
          ExDoc.Formatter.HTML.Autolink,
          ExDoc.FunctionNode,
          ExDoc.ModuleNode,
          ExDoc.TypeNode
        ]
      ]
    ]
  end

  defp clean_test_fixtures(_args) do
    File.rm_rf("test/tmp")
  end
end
