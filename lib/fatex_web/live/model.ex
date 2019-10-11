defmodule FatexWeb.ModelLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Form
  import FatexWeb.ErrorHelpers
  alias Fatex.LatexConfigs

  def render(assigns) do
    ~L"""
    <section>
      <%= main_menu(assigns) %>
      <div class="colums">
        <div class="column">
          temp
        </div>
        <div class="column">
          <%= user_input(assigns) %>
        </div>
      </div>
    </section>
    """
  end

  def main_menu(assigns) do
    ~L"""
    <div class="columns">
    <%= for step <- @steps do %>
      <div class="column button">
        <%= step.name %>
      </div>
    <% end %>
    </div>
    """
  end

  def user_input(assigns) do
    ~L"""
    <%= temp(assigns) %>
    """
  end

  def temp(assigns) do
    ~L"""
    <div class="box">
      <%= f = form_for @changeset, "#", [phx_change: :update] %>
        <%= label f, :id %>
        <%= text_input f, :id %>
        <%= error_tag f, :id %>

        <%= label f, :name %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>

        <%= label f, :type %>
        <%= text_input f, :type %>
        <%= error_tag f, :type %>

        <%= label f, :content %>
        <%= text_input f, :content %>
        <%= error_tag f, :content %>
      </form>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_params(_params = %{"id" => id}, _uri, socket) do
    steps = LatexConfigs.list_steps_from_model(String.to_integer(id))

    section =
      List.first(LatexConfigs.list_sections_from_step(List.first(steps)))
      |> LatexConfigs.Section.changeset(%{})

    {:noreply, assign(socket, steps: steps, changeset: section)}
  end

  alias LatexConfigs.Section

  def handle_event("update", %{"section" => params}, socket) do
    {_, changeset} =
      LatexConfigs.get_section(params["id"])
      |> LatexConfigs.update_section(params)

    changeset =
      changeset
      |> LatexConfigs.Section.changeset(%{})

    {:noreply, assign(socket, changeset: changeset)}
  end
end
