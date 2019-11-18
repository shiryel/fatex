defmodule FatexWeb.ModelLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.ModelView.render("index.html", assigns)
  end

  def mount(session, socket) do
    {:ok, assign(socket, session)}
  end

  def handle_params(_params = %{"model_id" => model_id}, _uri, socket) do
    model = LatexConfigs.get_model(model_id)
    steps = LatexConfigs.list_steps_from_model(model)

    {:noreply, assign(socket, steps: steps, step_choosed: nil, model_id: model_id)}
  end

  ##########
  # EVENTS #
  ##########

  def handle_event("choose_step", %{"step_id" => step_id}, socket) do
    step = LatexConfigs.get_step(step_id)

    {:noreply, update(socket, :step_choosed, fn _ -> step.id end)}
  end

  def handle_event("logoff", _params, socket) do
    {:stop, redirect(socket, to: FatexWeb.Router.Helpers.login_path(FatexWeb.Endpoint, :delete))}
  end

  def handle_event("account", _params, socket) do
    user_id = socket.assigns.user_id
    {:stop, redirect(socket, to: FatexWeb.Router.Helpers.user_path(FatexWeb.Endpoint, :edit, user_id))}
  end

  def handle_event("share", _params, socket) do
    {:noreply, socket}
  end
end
