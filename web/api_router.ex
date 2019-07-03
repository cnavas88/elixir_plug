defmodule ElixirPlug.Web.ApiRouter do
  @moduledoc """
  Api router contains the all routes that have the prefix path /api
  """

  use Plug.Router

  alias ElixirPlug.Web.Controllers, as: C
  # alias ElixirPlug.Web.Plugs.ValidateSignature

  # Use plug logger for logging request information
  plug(Plug.Logger)

  plug(:match)
  plug(:dispatch)

  # plug ValidateSignature

  get "/example",  do: C.ExampleController.run(conn)

  match _ do
    send_resp(conn, 404, "oops.. Nothing here :(")
  end
end
