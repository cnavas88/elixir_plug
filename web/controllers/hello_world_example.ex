defmodule ElixirPlug.Web.Controllers.HelloWorldController do
  @moduledoc """
  Hello world controller
  """
  import Plug.Conn

  @spec run(%Plug.Conn{}) :: %Plug.Conn{}

  def run(conn) do
    params = URI.decode_query(conn.query_string)

    send_resp(conn, 200, "Hello world #{params["name"]}")
  end

end
