defmodule ElixirPlug.Metrics do
  @moduledoc """
  In this module we generate the elixir_plug metrics.
  """

  use Prometheus.Metric

  alias Prometheus.InvalidMetricArityError
  alias Prometheus.InvalidValueError
  alias Prometheus.Metric.Counter
  alias Prometheus.UnknownMetricError

  @spec setup() :: {:ok, :ready}

  def setup() do
    Counter.declare(
      name: :version,
      help: "Control commit version",
      labels: [:version]
    )

    {:ok, :ready}
  end

  @spec inc(atom, keyword) :: :ok

  def inc(key, [labels: labels]) do
    Counter.inc([name: key, labels: labels])
  rescue
    InvalidValueError        ->  {:error, :invalid_value}
    UnknownMetricError       ->  {:error, :unknown_metric}
    InvalidMetricArityError  ->  {:error, :invalid_metric_arity}
  end
end
