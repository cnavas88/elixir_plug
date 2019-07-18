defmodule ElixirPlug.Web.Controllers.ISchema do
  @moduledoc """
  Interface for web Schemas validation
  """

  @callback get_schema() :: map()
end
