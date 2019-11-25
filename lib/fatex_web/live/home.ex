defmodule FatexWeb.HomeLive do
  @moduledoc """
  User homepage with all Model he is admin or have access (share)
  Initilized from `FatexWeb.LoginController` or `FatexWeb.UserController` when `FatexWeb.Auth` authenticate the user
  """

  use FatexWeb, :live
  alias FatexWeb.Router.Helpers

  def render(assigns) do
    FatexWeb.HomeView.render("index.html", assigns)
  end

  def mount(%{user_id: user_id}, socket) do
    models = 
      Fatex.Accounts.get_user(user_id)
      |> LatexConfigs.list_models_from_user()
      |> Enum.map(&Fatex.Repo.preload(&1, :user)) 

    {:ok, assign(socket, models: models, user_id: user_id, to_delete: false)}
  end

  def handle_event("go_to", %{"model_id" => model_id}, socket) do
    {:noreply,
      socket
        |> live_redirect(to: Routes.live_path(socket, FatexWeb.ModelLive, model_id))
    }
  end

  def handle_event("new", _params, socket) do
    {:noreply,
      socket
        |> live_redirect(to: Routes.live_path(socket, FatexWeb.ModelListLive, socket.assigns.user_id))
    }
  end

  def handle_event("to_delete", _params, socket) do
    {:noreply, assign(socket, :to_delete, not socket.assigns.to_delete)}
  end

  def handle_event("delete", %{"model_id" => model_id}, socket) do
    model_id
    |> Fatex.LatexConfigs.get_model()
    |> Fatex.LatexConfigs.delete_model()

    models = 
      Fatex.Accounts.get_user(1)
      |> LatexConfigs.list_models_from_user()
      |> Enum.map(&Fatex.Repo.preload(&1, :user)) 

    {:noreply, socket, models: models}
  end

  def handle_event("logoff", _params, socket) do
    {:stop, redirect(socket, to: Helpers.login_path(FatexWeb.Endpoint, :delete))}
  end

  def handle_event("account", _params, socket) do
    user_id = socket.assigns.user_id
    {:stop, redirect(socket, to: Helpers.user_path(FatexWeb.Endpoint, :edit, user_id))}
  end
end
