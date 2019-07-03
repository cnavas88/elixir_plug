defmodule ElixirPlug.Web.Controllers.ExampleController do
  @moduledoc """

  """
  import Plug.Conn

  @spec run(%Plug.Conn{}) :: %Plug.Conn{}

  def run(conn), do: send_resp(conn, 200, "Example")

end
