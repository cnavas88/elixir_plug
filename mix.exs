defmodule ElixirPlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_plug,
      version: "0.1.5",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      aliases: aliases(),
      elixirc_options: [warnings_as_errors: true],
      preferred_cli_env: [
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {ElixirPlug, []}
    ]
  end

  defp aliases do
    [
      quality: ["format", "credo --strict", "dialyzer", "inch"],
      "quality.ci": [
        "format --check-formatted",
        "credo --strict",
        "dialyzer --halt-exit-status"
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  defp deps do
    [
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.11.1", only: :test},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:harakiri, "~> 1.1"},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
      {:jason, "~> 1.1.2"},
      {:litmus, "~> 1.0.0"},
      {:mix_test_watch, "~> 0.8", only: [:dev, :test], runtime: false},
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.0"},
      {:observer_cli, "~> 1.4"}
    ]
  end
end
