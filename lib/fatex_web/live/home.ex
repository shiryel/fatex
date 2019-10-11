defmodule FatexWeb.HomeLive do
  use Phoenix.LiveView
  alias Fatex.LatexConfigs
  alias FatexWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
    <%= for model <- @models do %>
      <div class="box">
        <button phx-click="go_to" phx-value-id=<%= model.id %>><%= model.name %></button>
      </div>
    <% end %>
    """
  end

  def mount(_params, socket) do
    models = 
      Fatex.Accounts.get_user!(1)
      |> LatexConfigs.list_models_from_user()
    {:ok, assign(socket, models: models)}
  end

  def handle_event("go_to", %{"id" => id}, socket) do
    {:noreply,
      socket
        |> live_redirect(to: Routes.live_path(socket, FatexWeb.ModelLive, id))
    }
  end
end
