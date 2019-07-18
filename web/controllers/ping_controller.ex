defmodule ElixirPlug.Web.Controllers.PingController do
  @moduledoc """
  This controller contains the ping and flunk functions, this functions are
  for verify if elixir_plug is up (ping) or to force an error (flunk).
  """
  import Plug.Conn

  alias ElixirPlug.Web.Controllers.IController

  @behaviour IController

  @impl IController
  def run(conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "Pong")
  end

end
