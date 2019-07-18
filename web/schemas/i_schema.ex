defmodule ElixirPlug.Web.Schemas.ISchema do
  @moduledoc """
  Interface for web Schemas validation
  """

  @callback get_schema() :: map()
end
