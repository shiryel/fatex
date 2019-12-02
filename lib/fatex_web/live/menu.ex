defmodule FatexWeb.MenuLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.MenuView.render("index.html", assigns)
  end

  def mount(%{step_id: nil, model_id: model_id} = _session, socket) do
    {:ok, assign(socket, templates: [], model_id: model_id)}
  end

  def mount(%{step_id: id, model_id: model_id} = _session, socket) do
    step = LatexConfigs.get_step(id)
    templates =LatexConfigs.list_template_sections_from_step(step)

    {:ok, assign(socket, templates: templates, step_id: id, model_id: model_id)}
  end

  ##########
  # EVENTS #
  ##########
  
  def handle_event("add_image", params, socket) do
    IO.inspect(params)
    #if photo do
    #  path = Render.Core.FileHandler.get_path(socket.assigns.model_id)
    #  File.cp(photo.path, "#{path}/#{photo.filename}")
    #end

    {:noreply, socket}
  end

  def handle_event("to_add", %{"template_id" => template_id}, socket) do
    PubSub.broad_to_add(socket.assigns.step_id, template_id)
    {:noreply, socket}
  end
end
