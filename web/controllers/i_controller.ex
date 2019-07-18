defmodule ElixirPlug.Web.Controllers.IController do
  @moduledoc """
  Interface for web controllers
  """

  @callback run(%Plug.Conn{}) :: %Plug.Conn{}
end
