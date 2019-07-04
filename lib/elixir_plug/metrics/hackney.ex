defmodule ElixirPlug.Metrics.Hackney do
  @moduledoc """
  This module serves for generate Hackney metrics. The active functions are
  increment counter and incement and decrement gauge.
  """
  alias ElixirPlug.Metrics

  @type prometheus_error :: Metrics.prometheus_error

  def new(_type, _opts), do: :ok

  def delete(_name, _config), do: :ok

  @spec increment_counter([...]) :: :ok | prometheus_error

  def increment_counter([:hackney, host, :nb_requests]) do
    spec = [name: :nb_requests, labels: [host]]
    unwrap(Metrics.gauge_inc(spec))
  end

  def increment_counter([:hackney, :total_requests]), do:
    unwrap(Metrics.inc(:total_requests))

  def increment_counter([:hackney, :finished_requests]), do:
    unwrap(Metrics.inc(:finished_requests))

  def increment_counter([:hackney_pool, host, :new_connection]), do:
    unwrap(Metrics.inc(:new_connection, [labels: [host]]))

  def increment_counter([:hackney_pool, host, :reuse_connection]), do:
    unwrap(Metrics.inc(:reuse_connection, [labels: [host]]))

  def increment_counter([:hackney_pool, pool, :no_socket]), do:
    unwrap(Metrics.inc(:no_socket, [labels: [pool]]))

  def increment_counter([:hackney, host, :connect_error]), do:
    unwrap(Metrics.inc(:connect_error, [labels: [host]]))

  def increment_counter([:hackney, :nb_requests]) do
    spec = [name: :nb_requests, labels: ["totals"]]
    unwrap(Metrics.gauge_inc(spec))
  end

  def increment_counter(_arg), do: :ok

  def increment_counter(_arg, _arg2), do: :ok

  @spec decrement_counter([...]) :: :ok | {:error, any}

  def decrement_counter([:hackney, host, :nb_requests]) do
    spec = [name: :nb_requests, labels: [host]]
    unwrap(Metrics.gauge_dec(spec))
  end

  def decrement_counter([:hackney, :nb_requests]) do
    spec = [name: :nb_requests, labels: ["totals"]]
    unwrap(Metrics.gauge_dec(spec))
  end

  def decrement_counter(_arg, _arg2), do: :ok

  def update_histogram(_arg, func) when is_function(func, 0), do: :ok

  def update_histogram([:hackney, host, :request_time], value) do
    spec = [name: :request_time, labels: [host]]
    unwrap(Metrics.histogram_observe(spec, value))
  end

  def update_histogram([:hackney_pool, pool, :in_use_count], value) do
    spec = [name: :in_use_count, labels: [pool]]
    unwrap(Metrics.histogram_observe(spec, value))
  end

  def update_histogram([:hackney_pool, pool, :free_count], value) do
    spec = [name: :free_count, labels: [pool]]
    unwrap(Metrics.histogram_observe(spec, value))
  end

  def update_histogram(_arg, _arg2), do: :ok

  def update_gauge(_arg, _arg2), do: :ok

  def update_meter(_arg, _arg2), do: :ok

  def increment_spiral(_arg), do: :ok

  def increment_spiral(_arg, _arg2), do: :ok

  def decrement_spiral(_arg), do: :ok

  def decrement_spiral(_arg, _arg2), do: :ok

  #######################
  # Auxiliary functions #
  #######################

  defp unwrap({:ok, _val}), do: :ok
  defp unwrap(error), do: error

end
