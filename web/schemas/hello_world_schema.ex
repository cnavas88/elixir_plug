defmodule ElixirPlug.Web.Schemas.HelloWorld do
  @moduledoc """
  Schema for /api/hello_world
  """
  alias ElixirPlug.Web.Controllers.ISchema

  @behaviour ISchema

  @schema %{
    "name" => %Litmus.Type.String{
      min_length: 6,
      max_length: 12,
      required: true
    }
  }

  @impl ISchema
  def get_schema, do: @schema

end
