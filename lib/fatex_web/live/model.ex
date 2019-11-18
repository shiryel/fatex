defmodule FatexWeb.ModelLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.ModelView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(_params = %{"model_id" => model_id}, _uri, socket) do
    conn_params = get_connect_params(socket)
    model = LatexConfigs.get_model(model_id)
    steps = LatexConfigs.list_steps_from_model(model)

    {:noreply, assign(socket, steps: steps, step_choosed: nil, model_id: model_id, conn_params: conn_params)}
  end

  ##########
  # EVENTS #
  ##########

  def handle_event("choose_step", %{"step_id" => step_id}, socket) do
    step = LatexConfigs.get_step(step_id)

    {:noreply, update(socket, :step_choosed, fn _ -> step.id end)}
  end

end
