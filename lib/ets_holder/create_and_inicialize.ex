defmodule ElixirPlug.EtsHolder.CreateAndInicialize do
  @moduledoc """
  This module contains the function for create and inicialize the ets table.
  The ets tables are configures in the configuration files.
  ets table name and the inicialize module.
  """
  require Logger

  alias Sheldon.Helpers.Ets

  @module_inicialize_ets ElixirPlug.EtsHolder.Inicialize

  defmodule State do
    @moduledoc """
    State with the most important dates for create and inicializate ets tables
    - name: name of table.
    - typed: typed of ets table.
    - module: module for call to inicializate dates.
    - data: inicializate data.
    """
    defstruct [
      :name,
      :typed,
      :module,
      :data,
      create_ets_fn: &Ets.create/2,
      insert_ets_fn: &Ets.insert/2
    ]
  end

  defmodule Error do
    @moduledoc """
    State for errors
    """
    defstruct [
      :state,
      :reason
    ]
  end

  @spec run(Keyworlist) :: :ok | {:error, atom}

  def run(opts) do
    opts
    |> struct(State)
    |> create_ets_table()
    |> module_exists()
    |> get_data_from_module()
    |> insert_into_ets()
    |> respond()
  end

  @spec create_ets_table(%State{}) :: %State{} | %Error{}

  defp create_ets_table(%State{name: name, typed: typed} = state) do
    case state.create_ets_fn.(name, typed) do
      {:ok, _name_ets} ->
        Logger.info(">>> Create ets table...")
        state

      _error ->
        %Error{state: state, reason: :dont_create_ets_table}
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
      {:error, :module_doesnt_exists}
  end

  @spec generate_module(atom) :: atom

  defp generate_module(module) do
    to_string(@module_inicialize_ets) <> "." <> Atom.to_string(module)
    |> String.to_existing_atom()
  end

  @spec get_data_from_module(%State{} | %Error{}) :: %State{} | %Error{}

  defp get_data_from_module(%State{module: nil} = state), do: state
  defp get_data_from_module(%State{module: module} = state) do
    %State{state | data: module.run.()}
  end
  defp get_data_from_module(%Error{} = error), do: error

  @spec insert_into_ets(%State{} | %Error{}) :: %State{} | %Error{}

  defp insert_into_ets(%State{module: nil} = state), do: state
  defp insert_into_ets(%State{data: data, name: name} = state) do
    Enum.each(data, fn row ->
      state.insert_ets_fn.(name, row)
    end)
    state
  end
  defp insert_into_ets(%Error{} = error), do: error

  @spec respond(%State{} | %Error{}) :: :ok | {:error, atom}

  defp respond(%State{} = _state), do: :ok
  defp respond(%Error{reason: reason} = _error) do
    {:error, reason}
  end

end
