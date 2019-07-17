defmodule ElixirPlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_plug,
      version: "0.1.0",
      elixir: "~> 1.8.1-otp-21",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
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

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [
      {:credo,            "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:dialyxir,         "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:distillery,       "~> 2.0"},
      {:excoveralls,      "~> 0.11.1", only: :test},
      {:jason,            "~> 1.1.2"},
      {:mix_test_watch,   "~> 0.8", only: [:dev, :test], runtime: false},
      {:plug_cowboy,      "~> 2.0"},
      {:plug,             "~> 1.0"},
      {:prometheus_plugs, "~> 1.1.5"},
      {:prometheus_ex,    "~> 3.0"},
      {:observer_cli,     "~> 1.4"}
    ]
  end
end
