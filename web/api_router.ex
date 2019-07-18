defmodule ElixirPlug.Web.ApiRouter do
  @moduledoc """
  Api router contains the all routes that have the prefix path /api
  """
  use Plug.Router

  alias ElixirPlug.Web.Controllers, as: C
  alias ElixirPlug.Web.Plugs.ErrorHelpers
  alias ElixirPlug.Web.Schemas.{HelloWorld}

  # Use plug logger for logging request information
  plug(Plug.Logger)

  plug(:match)

  plug(Litmus.Plug, on_error: &ErrorHelpers.on_error/2)

  plug(:dispatch)

  get "/hello_world", private: %{litmus_query: HelloWorld.get_schema()}, do:
    C.HelloWorldController.run(conn)

  match _ do
    send_resp(conn, 404, "oops.. Nothing here :(")
  end

end
