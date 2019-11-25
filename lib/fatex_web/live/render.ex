defmodule FatexWeb.RenderLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.RenderView.render("index.html", assigns)
  end

  def mount(%{model_id: model_id}, socket) do
    PubSub.broad_render(model_id)
    {:ok, assign(socket, model_id: model_id, render: :rand.uniform())}
  end

  ##########
  # EVENTS #
  ##########

  def handle_event("render", _values, socket) do
    PubSub.broad_render(socket.assigns.model_id)
    {:noreply, assign(socket, render: :rand.uniform())} 
  end

end
