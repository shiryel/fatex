defmodule FatexWeb.PubSub.Live do
  @moduledoc """
  Module to handle pubsub subscribes and broadcasts in the live view context
  """

  alias Phoenix.PubSub
  require Logger

  @doc """
  Subscribe to the to_add messages
  These messages is received with a {:to_add, template_id}
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

  @doc """
  Subscribe to the render messages
  These messages is received with a {:render, model_id}
  """
  def sub_render() do
    PubSub.subscribe(Fatex.PubSub, "render")
  end

  @doc """
  Broadcast to the render messages
  These messages is send to a module to render the pdf of the latex in the steps of the model id
  """
  def broad_render(model_id) do
    PubSub.broadcast(Fatex.PubSub, "render", {:render, model_id})
  end

  @doc """
  Subscribe to the reflesh messages
  These messages is received with a :reflesh
  """
  def sub_reflesh(step_id) do
    PubSub.subscribe(Fatex.PubSub, "#{step_id}:reflesh")
  end

  @doc """
  Broadcast to the to_add messages
  These messages is send to a step id 
  """
  def broad_reflesh(step_id) do
    PubSub.broadcast(Fatex.PubSub, "#{step_id}:reflesh", :reflesh)
  end
end
