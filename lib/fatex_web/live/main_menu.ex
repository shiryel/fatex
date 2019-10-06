defmodule FatexWeb.MainMenuLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div class="columns">
    <%= for item <- @steps do %>
      <div class="column button">
        <%= item %>
      </div>
    <% end %>
    </div>
    """
  end

  def mount(_params, socket) do
    {:ok, assign(socket, steps: ["Informações", "Introdução", "Desenvolvimento", "Testes / Resultados", "Discussão / Conclusão"])}
  end
end
