defmodule ElixirPlug.EtsHolder.Inicialize.IInicialize do
  @moduledoc """
  Interface for inicialize ets tables
  """

  # Return list of maps
  @callback inicialize() :: list
end
