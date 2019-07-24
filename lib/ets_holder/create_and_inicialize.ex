defmodule ElixirPlug.EtsHolder.CreateAndInicialize do
  @moduledoc """
  This module contains the function for create and inicialize the ets table.
  The ets tables are configures in the configuration files.
  ets table name and the inicialize module.
  """
  require Logger

  alias Sheldon.Helpers.Ets

  def run(opts) do
    opts
    |> create_ets_table()
    |> respond()
  end

  defp create_ets_table(opts) do
    case Ets.create(opts.name, opts.typed) do
      {:ok, _name_ets} -> {:ok, opts}
                 error -> error
    end
  end

  defp respond({:ok, opts}) do
    Logger.info("Create ets table: #{inspect opts.name}")
    :ok
  end
  defp respond({:error, reason}) do
    Logger.error(reason)
    {:error, reason}
  end

end
