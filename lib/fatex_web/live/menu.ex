defmodule FatexWeb.MenuLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.MenuView.render("index.html", assigns)
  end

  def mount(%{step_id: nil} = _session, socket) do
    step = LatexConfigs.get_step(1)
    templates =LatexConfigs.list_template_sections_from_step(step)

    {:ok, assign(socket, templates: templates, to_add: nil)}
  end

  def mount(%{step_id: id} = _session, socket) do
    step = LatexConfigs.get_step(id)
    templates =LatexConfigs.list_template_sections_from_step(step)

    {:ok, assign(socket, templates: templates, to_add: nil)}
  end
end
