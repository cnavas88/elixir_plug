defmodule ElixirPlug.Web.Schemas.HelloWorld do
  @moduledoc """
  Schema for /api/hello_world
  """
  @schema %{
    "name" => %Litmus.Type.String{
      min_length: 6,
      max_length: 12,
      required: true
    }
  }

  def get_schema, do: @schema

end
