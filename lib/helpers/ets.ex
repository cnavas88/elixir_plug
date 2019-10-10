defmodule Sheldon.Helpers.Ets do
  @moduledoc """
  Ets Helpers
  """

  @spec create(atom, atom) :: {:error, :ets_not_created} | {:ok, atom()}

  @doc """
  this function create a ets table with the table name parameter as atom and
  the type parameter as an atom. The all tables will be create public and
  named tables. If the table creation is ok, this function return the tuple
  {:ok, atom table name}.
  If the creation table fails, handle an Argument error thats return the tuple
  {:error, :ets_not_created}
  """
  def create(table, type) do
    {:ok, :ets.new(table, [:public, :named_table, type])}
  rescue
    _e in ArgumentError ->
      {:error, :ets_not_created}
  end

  @spec lookup(atom, String.t()) :: :none | {:ok, tuple()}

  @doc """
  This function get the key of the table, enter two parameters, the table name
  as an atom and the key as a string. This function return:
  - :none -> if the lookup is a empty list or list with a one tuple with 0 items
  - {:ok, data} -> if the lookup find the data
  """
  def lookup(ets_table, key) do
    case :ets.lookup(ets_table, key) do
      [] -> :none
      [{_, 0}] -> :none
      [{_, ets_data}] -> {:ok, ets_data}
    end
  end

  @spec lookup_all(atom) :: list

  @doc """
  This function get the all data of the table, enter a parameter, the table name
  as an atom. This function return a list with the all data.
  """
  def lookup_all(ets_table) do
    :ets.foldl(
      fn data, acc ->
        acc ++ [data]
      end,
      [],
      ets_table
    )
  end

  @spec insert(atom, tuple) :: boolean

  @doc """
  This function insert a tuple into the ets table. Has two parameters, the table
  name as an atom and the tuple with the insert data. if this function insert
  the data return a boolean. if not insert the data handle an exception
  Argument error and return the tuple {:error, :not_insert}
  """
  def insert(table, row) do
    :ets.insert(table, row)
  rescue
    _e in ArgumentError ->
      {:error, :not_insert}
  end

  @spec first(atom) :: list

  @doc """
  This function get the first row of ets table, and return it into the liost.
  the parameter is an table name atom.
  """
  def first(table) do
    :ets.first(table)
  end

  @spec next(atom, String.t()) :: list

  @doc """
  This function get the next data according a pointer. Return the data into
  a list.
  """
  def next(table, current_key) do
    :ets.next(table, current_key)
  end
end
