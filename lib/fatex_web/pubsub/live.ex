defmodule FatexWeb.PubSub.Live do
  @moduledoc """
  Module to handle pubsub subscribes and broadcasts in the live view context
  """

  alias Phoenix.PubSub

  @doc """
  Subscribe to the to_add messages
  These messages is send to a step id
  """
  def sub_to_add(step_id) do
    PubSub.subscribe(Fatex.PubSub, "#{step_id}:to_add")
  end

  @doc """
  Broadcast to the to_add messages
  These messages is send to a step id with a template id to the step search on the database
  """
  def broad_to_add(step_id, template_id) do
    PubSub.broadcast(Fatex.PubSub, "#{step_id}:to_add", {:to_add, template_id})
  end
end
