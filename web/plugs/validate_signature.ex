defmodule ElixirPlug.Web.Plugs.ValidateSignature do
  @moduledoc """
  This plug is for validate the signature. If the signature is wrong, the request
  is rejected with 401 HTTP code: unauthorized
  """
  import Plug.Conn

  @body_methods ["POST", "PUT", "DELETE"]

  @spec init(map) :: map

  def init(opts), do: opts

  @spec call(%Plug.Conn{}, map) :: %Plug.Conn{}

  def call(%Plug.Conn{method: method} = conn, opts)
    when method in @body_methods do
      validate_signed_body(conn)
  end
  def call(%Plug.Conn{method: method} = conn, opts) do
    validate_signed_url(conn)
  end

  @spec validate_signed_body(%Plug.Conn{}) :: %Plug.Conn{}

  defp validate_signed_body(%Plug.Conn{body_params: body} = conn) do
    IO.puts "CONNNN :: #{inspect conn}"
    IO.puts "BODYYY :: #{inspect conn.body_params}"
    conn
  end

  @spec validate_signed_url(%Plug.Conn{}) :: %Plug.Conn{}

  defp validate_signed_url(%Plug.Conn{query_string: query_string} = conn) do
    IO.puts "QUERY STRING :: #{inspect query_string}"
    conn
  end
end
