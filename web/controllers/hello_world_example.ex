defmodule ElixirPlug.Web.Controllers.HelloWorldController do
  @moduledoc """
  Hello world controller
  """
  import Plug.Conn

  @spec run(%Plug.Conn{}) :: %Plug.Conn{}

  def run(conn), do: send_resp(conn, 200, "Hello world")

end
