defmodule ElixirPlug do
  @moduledoc """
  ElixirPlug is the v3 of irvine project.
  """
  use Application

  alias ElixirPlug.Metrics
  alias ElixirPlug.Web.Controllers.VersionController
  alias ElixirPlug.Web.{MetricsExporter, MetricsInstrumenter, Router}
  alias Plug.Cowboy

  def start(_type, _args) do

    Metrics.setup()
    MetricsExporter.setup()
    MetricsInstrumenter.setup()

    Metrics.inc(:version, [labels: [VersionController.get_commit_version()]])

    children = [
      Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: Application.get_env(:elixir_plug, :port)]
      )
    ]

    opts = [strategy: :one_for_one, name: ElixirPlug.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
