use Mix.Config

config :elixir_plug, port: 4001

config :elixir_plug, ets_tables: [
  %{
    name: :cache,
    typed: :set,
    module: nil
  },
  %{
    name: :example,
    typed: :set,
    module: :example
  }
]
