defmodule ElixirPlug.Web.Plugs.ErrorHelpers do
  @moduledoc """
  This module contains the functions for parse and generate errors json or
  in text plain.
  """

  @spec on_error(%Plug.Conn{}, String.t) :: %Plug.Conn{}

  def on_error(conn, error_message) do
    conn
    |> Plug.Conn.send_resp(400, jsonable_error(error_message))
    |> Plug.Conn.halt()
  end

  @spec jsonable_error(String.t) :: String.t

  defp jsonable_error(error_message) do
    Jason.encode!(%{"error" => error_message})
  end

end
