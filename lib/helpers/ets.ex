defmodule Sheldon.Helpers.Ets do
  @moduledoc """
  Ets Helpers
  """

  @spec create(atom, atom) :: :ok

  def create(table, type) do
    {:ok, :ets.new(table, [:public, :named_table, type])}
  rescue
    _e in ArgumentError ->
      {:error, :ets_not_created}
  end

  @spec lookup(atom, String.t()) :: list

  def lookup(ets_table, key) do
    case :ets.lookup(ets_table, key) do
      [] -> :none
      [{_, 0}] -> :none
      [{_, ets_data}] -> {:ok, ets_data}
    end
  end

  @spec lookup_all(atom) :: list

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

  def insert(table, row) do
    :ets.insert(table, row)
  rescue
    _e in ArgumentError ->
      {:error, :not_insert}
  end

  @spec first(atom) :: list

  def first(table) do
    :ets.first(table)
  end

  @spec next(atom, String.t()) :: list

  def next(table, current_key) do
    :ets.next(table, current_key)
  end
end
