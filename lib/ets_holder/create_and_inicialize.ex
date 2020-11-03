defmodule ElixirPlug.EtsHolder.CreateAndInicialize do
  @moduledoc """
  This module contains the function for create and inicialize the ets table.
  The ets tables are configures in the configuration files.
  ets table name and the inicialize module.
  """
  require Logger

  alias __MODULE__, as: State
  alias Sheldon.Helpers.Ets

  @module_inicialize_ets ElixirPlug.EtsHolder.Inicialize

  defstruct [
    :name,
    :typed,
    :module,
    :data,
    create_ets_fn: &Ets.create/2,
    insert_ets_fn: &Ets.insert/2
  ]

  defmodule Error do
    @moduledoc """
    State for errors
    """
    defstruct [
      :state,
      :reason
    ]
  end

  @spec run([any]) :: :ok | {:error, atom}

  def run(opts) do
    State
    |> struct(opts)
    |> create_ets_table()
    |> module_exists()
    |> get_data_from_module()
    |> start_insert_into_ets()
    |> respond()
  end

  @spec create_ets_table(%State{}) :: %State{} | %Error{}

  defp create_ets_table(%State{name: name, typed: typed} = state) do
    case state.create_ets_fn.(name, typed) do
      {:ok, _name_ets} ->
        Logger.info(">>> Create ets table...")
        state

      {:error, reason} ->
        %Error{state: state, reason: reason}
    end
  end

  @spec module_exists(%State{} | %Error{}) :: %State{} | %Error{}

  defp module_exists(%State{module: nil} = state), do: state

  defp module_exists(%State{module: module} = state) do
    Logger.info(">>> Inicialize ets table...")

    case exists_and_get_module(module) do
      {:ok, existing_module} ->
        %State{state | module: existing_module}

      {:error, reason} ->
        %Error{state: state, reason: reason}
    end
  end

  defp module_exists(%Error{} = error), do: error

  @spec exists_and_get_module(atom) :: {:ok, atom} | {:error, atom}

  defp exists_and_get_module(module) do
    {:ok, generate_module(module)}
  rescue
    _e in ArgumentError ->
      {:error, :module_doesnt_exist}
  end

  @spec generate_module(atom) :: atom

  defp generate_module(module) do
    (to_string(@module_inicialize_ets) <> "." <> Atom.to_string(module))
    |> String.to_existing_atom()
  end

  @spec get_data_from_module(%State{} | %Error{}) :: %State{} | %Error{}

  defp get_data_from_module(%State{module: nil} = state), do: state

  defp get_data_from_module(%State{module: module} = state) do
    %State{state | data: module.inicialize()}
  end

  defp get_data_from_module(%Error{} = error), do: error

  @spec start_insert_into_ets(%State{} | %Error{}) :: %State{} | %Error{}

  defp start_insert_into_ets(%State{module: nil} = state), do: state

  defp start_insert_into_ets(%State{data: data, name: name} = state) do
    get_result_insert(data, name, state.insert_ets_fn)
    state
  end

  defp start_insert_into_ets(%Error{} = error), do: error

  @spec get_result_insert(list, atom, function) :: atom

  defp get_result_insert(data, name, insert_fn) do
    data
    |> Enum.map(&insert_into_ets(&1, name, insert_fn))
    |> Enum.filter(&filter_error/1)
    |> see_result(length(data))
  end

  @spec insert_into_ets(list, atom, function) :: atom

  defp insert_into_ets(row, name, insert_fn) do
    case insert_fn.(name, row) do
      true -> :ok
      {:error, _reason} -> :error
    end
  end

  @spec filter_error(list) :: boolean

  defp filter_error(result), do: result == :error

  @spec see_result(list, integer) :: atom

  defp see_result(filter, _data) when filter == [] do
    Logger.info(">>> Data insert OK.")
  end

  defp see_result(filter, length_data) do
    if length(filter) == length_data do
      Logger.error(">>> Data insert Error.")
    else
      Logger.warn(">>> Partial Data insert.")
    end
  end

  @spec respond(%State{} | %Error{}) :: :ok | {:error, atom}

  defp respond(%State{} = _state), do: :ok

  defp respond(%Error{reason: reason} = _error), do: {:error, reason}
end
