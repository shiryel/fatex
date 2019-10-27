defmodule FatexWeb.MenuLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.MenuView.render("index.html", assigns)
  end

  def mount(%{step_id: nil} = _session, socket) do
    {:ok, assign(socket, templates: [])}
  end

  def mount(%{step_id: id} = _session, socket) do
    step = LatexConfigs.get_step(id)
    templates =LatexConfigs.list_template_sections_from_step(step)

    {:ok, assign(socket, templates: templates, step_id: id)}
  end

  def handle_event("to_add", %{"template_id" => template_id}, socket) do
    PubSub.broad_to_add(socket.assigns.step_id, template_id)
    {:noreply, socket}
  end
end
