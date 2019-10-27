defmodule FatexWeb.StepLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.StepView.render("index.html", assigns)
  end

  def mount(%{step_id: nil} = _session, socket) do
    {:ok, assign(socket, root_sections: [])}
  end

  def mount(%{step_id: id} = _session, socket) do
    root_sections =
      LatexConfigs.get_step(id)
      |> LatexConfigs.list_sections_from_step()

    {:ok, assign(socket, root_sections: root_sections, step_id: id)}
  end
end
