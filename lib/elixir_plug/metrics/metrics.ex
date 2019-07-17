defmodule ElixirPlug.Metrics do
  @moduledoc """
  In this module we generate the elixir_plug metrics.
  """
  use Prometheus.Metric

  alias Prometheus.{InvalidMetricArityError, InvalidValueError, UnknownMetricError}

  @spec setup() :: {:ok, :ready}

  def setup do
    Counter.declare(
      name: :version,
      help: "Control commit version",
      labels: [:version]
    )

    #
    # Hackney metrics
    #

    Histogram.declare(
      name: :request_time,
      help: "request time for host",
      labels: [:host]
    )

    Histogram.declare(
      name: :in_use_count,
      help: "in use count for pool",
      labels: [:pool]
    )

    Histogram.declare(
      name: :free_count,
      help: "free count for pool",
      labels: [:pool]
    )

    Gauge.declare(
      name: :nb_requests,
      help: ":nb_requests hackney metrics",
      labels: [:host]
    )

    Counter.declare(
      name: :new_connection,
      help: ":new connection hackney metrics",
      labels: [:host]
    )

    Counter.declare(
      name: :reuse_connection,
      help: ":reuse connection hackney metrics",
      labels: [:host]
    )

    Counter.declare(
      name: :connect_error,
      help: ":connect error hackney metrics",
      labels: [:host]
    )

    Counter.declare(
      name: :no_socket,
      help: ":no socket error hackney metrics",
      labels: [:pool]
    )

    Counter.declare(
      name: :total_requests,
      help: ":total_requests hackney metrics",
      labels: []
    )

    Counter.declare(
      name: :finished_requests,
      help: ":finished_requests hackney metrics",
      labels: []
    )

    {:ok, :ready}
  end

  @spec inc(atom, keyword) :: :ok

  def inc(key, opts \\ [labels: []]) do
    labels = Keyword.get(opts, :labels)
    Counter.inc([name: key, labels: labels])
  rescue
    InvalidValueError        ->  {:error, :invalid_value}
    UnknownMetricError       ->  {:error, :unknown_metric}
    InvalidMetricArityError  ->  {:error, :invalid_metric_arity}
  end

  @spec gauge_inc(keyword, number) :: :ok

  def gauge_inc(spec, value \\ 1), do: Gauge.inc(spec, value)

  @spec gauge_dec(keyword, number) :: :ok

  def gauge_dec(spec, value \\ 1), do: Gauge.dec(spec, value)

  @spec histogram_observe(keyword, keyword) :: :ok

  def histogram_observe(spec, value), do: Histogram.observe(spec, value)
end
