defmodule FatexWeb.ModelListLive do
  @moduledoc """
  To choose who model template copy for the user
  Initilized from `FatexWeb.HomeLive`
  """
  use FatexWeb, :live
  require Logger
  alias FatexWeb.Router.Helpers

  def render(assigns) do
    FatexWeb.ModelListView.render("index.html", assigns)
  end

  def mount(session, socket) do
    template_models =
      Fatex.LatexConfigs.list_models_templates()
      |> Enum.map(&Fatex.Repo.preload(&1, :user))

    socket =
      socket
      |> assign(session)
      |> assign(:models, template_models)
      |> assign(:model_name, "")

    {:ok, socket}
  end

  def handle_params(_params = %{"user_id" => user_id}, _uri, socket) do
    {:noreply, assign(socket, user_id: user_id, model_name: "")}
  end

  ##########
  # EVENTS #
  ##########

  def handle_event("back_home", _params, socket) do
    {:stop, redirect(socket, to: Routes.live_path(socket, FatexWeb.HomeLive))}
  end

  def handle_event("validate_name", %{"model_name" => %{"name" => name}}, socket) do
    {:noreply, assign(socket, model_name: name)}
  end

  def handle_event("copy", %{"model_id" => model_id}, socket) do
    user_id = String.to_integer(socket.assigns.user_id)
    model_name = socket.assigns.model_name

    Fatex.LatexConfigs.clone_model_template(model_id, user_id, model_name)

    {:stop, redirect(socket, to: Routes.live_path(socket, FatexWeb.HomeLive))}
  end
end
