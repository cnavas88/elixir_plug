defmodule ElixirPlug.EtsHolder.Inicialize.Example do
  @moduledoc """
  Example module for inicializate the ets table :example
  """
  alias ElixirPlug.EtsHolder.Inicialize.IInicialize

  @behaviour IInicialize

  @impl IInicialize
  def inicialize, do: [{"example", "ok"}, :error]
end
