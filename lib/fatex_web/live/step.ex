defmodule FatexWeb.StepLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.StepView.render("index.html", assigns)
  end

  def mount(%{step_id: nil} = _session, socket) do
    {:ok, assign(socket, sections: [], step_id: nil)}
  end

  def mount(%{step_id: id} = _session, socket) do
    sections =
      LatexConfigs.get_step(id)
      |> LatexConfigs.list_sections_from_step()

    {:ok, assign(socket, sections: sections, step_id: id)}
  end

end
