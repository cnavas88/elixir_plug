# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:request_id]

if Mix.env == :dev do
  config :mix_test_watch,
    tasks: [
      "test --cover",
      "credo --strict",
    ]
end

import_config "#{Mix.env()}.exs"
