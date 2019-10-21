defmodule FatexWeb.HomeLive do
  use FatexWeb, :live

  def render(assigns) do
    FatexWeb.HomeView.render("index.html", assigns)
  end

  def mount(_params, socket) do
    models = 
      Fatex.Accounts.get_user(1)
      |> LatexConfigs.list_models_from_user()

    {:ok, assign(socket, models: models)}
  end

  def handle_event("go_to", %{"model_id" => model_id}, socket) do
    {:noreply,
      socket
        |> live_redirect(to: Routes.live_path(socket, FatexWeb.ModelLive, model_id))
    }
  end
end
