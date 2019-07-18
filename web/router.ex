defmodule ElixirPlug.Web.Router do
  @moduledoc """
  ElixirPlug router where we configure the all routes or middlewares.
  """

  use Plug.Router

  alias ElixirPlug.Web.Controllers, as: C

  # Use plug logger for logging request information
  plug(Plug.Logger)

  plug(:match)
  plug ElixirPlug.Web.MetricsInstrumenter
  plug ElixirPlug.Web.MetricsExporter
  plug(:dispatch)

  forward "/api", to: ElixirPlug.Web.ApiRouter

  get "/flunk",   do: C.PingController.flunk(conn)
  get "/ping",    do: C.PingController.ping(conn)
  get "/version", do: C.VersionController.run(conn)

  match _ do
    send_resp(conn, 404, "oops.. Nothing here :(")
  end
end
