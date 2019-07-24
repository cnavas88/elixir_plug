defmodule ElixirPlug.EtsHolder.CreateAndInicialize do
  @moduledoc """
  This module contains the function for create and inicialize the ets table.
  The ets tables are configures in the configuration files.
  ets table name and the inicialize module.
  """
  require Logger

  alias Sheldon.Helpers.Ets

  @module_inicialize_ets ElixirPlug.EtsHolder.Inicialize

  def run(opts) do
    Logger.info("Ets worker --> #{inspect opts.name}")
    opts
    |> create_ets_table()
    |> inicialize_table()
    |> respond()
  end

  defp create_ets_table(opts) do
    case Ets.create(opts.name, opts.typed) do
      {:ok, _name_ets} -> Logger.info(">>> Create ets table...")
                          {:ok, opts}
                 error -> error
    end
  end

  defp inicialize_table({:ok, %{module: nil} = opts}), do: {:ok, opts}
  defp inicialize_table({:ok, %{module: module} = opts}) do
    Logger.info(">>> Inicialize ets table...")
    case exists_and_get_module(module) do
      {:ok, _} -> {:ok, opts}
         error -> error
    end
  end
  defp inicialize_table(x), do: x

  defp exists_and_get_module(module) do
    {:ok, generate_module(module)}
  rescue
    _e in ArgumentError ->
      {:error, :module_doesnt_exists}
  end

  defp generate_module(module) do
    to_string(@module_inicialize_ets) <> "." <> Atom.to_string(module)
    |> String.to_existing_atom()
  end

  defp respond({:ok, opts}) do
    :ok
  end
  defp respond({:error, reason}) do
    Logger.error(reason)
    {:error, reason}
  end

end
