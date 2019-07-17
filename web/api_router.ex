defmodule ElixirPlug.Web.ApiRouter do
  @moduledoc """
  Api router contains the all routes that have the prefix path /api
  """

  use Plug.Router

  alias ElixirPlug.Web.Controllers, as: C

  # Use plug logger for logging request information
  plug(Plug.Logger)

  plug(:match)
  plug(:dispatch)

  get "/hello_world",  do: C.HelloWorldController.run(conn)

  match _ do
    send_resp(conn, 404, "oops.. Nothing here :(")
  end
end
