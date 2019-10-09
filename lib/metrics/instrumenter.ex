# defmodule ElixirPlug.Instrumenter do
#   @moduledoc """
#   TODOOOOO
#   """
#   require Logger

#   def setup do
#     events = [
#       [:web, :request, :start],
#       [:web, :request, :success],
#       [:web, :request, :failure],
#     ]
  
#     :telemetry.attach_many("myapp-instrumenter", events, &handle_event/4, nil)
#   end

#   def handle_event([:web, :request, :start], measurements, metadata, _config) do
#     Logger.info inspect("START REQUEST")
#     Logger.info inspect(measurements)
#     Logger.info inspect(metadata)
#   end

#   def handle_event([:web, :request, :success], measurements, metadata, _config) do
#     Logger.info inspect("SUCCESS REQUEST")
#     Logger.info inspect(measurements)
#     Logger.info inspect(metadata)
#   end

#   def handle_event([:web, :request, :failure], measurements, metadata, _config) do
#     Logger.info inspect("FAILURE REQUEST")
#     Logger.info inspect(measurements)
#     Logger.info inspect(metadata)
#   end   
# end