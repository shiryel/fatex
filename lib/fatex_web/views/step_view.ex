defmodule FatexWeb.StepView do
  use FatexWeb, :view
  alias Fatex.LatexConfigs

  def show_sections_from_step(assigns, nil) do
    ~L"""
    Escolha uma opção da lista acima
    """
  end

  def show_sections_from_step(assigns, step) do
    sections = LatexConfigs.list_sections_from_step(step)
      |> Enum.map(&(LatexConfigs.change_section(&1)))
    ~L"""
    <%= for section <- sections do %>
      <%= f = form_for section, "#", [phx_change: :update_section] %>
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
        <%= if @to_add != nil do %>
          <div phx-click="append_child" phx-value-to_add="<%= @to_add %>" phx-value-section_id="<%= section.data.id %>" class="column button">
            adicionar filho
          </div>
        <% end %>
      <section>
        <%= if length(section.data.children) > 0 do %>
          <%= show_children_sections(assigns, section.data) %>
        <% end %>
      <section>
    <% end %>
    """
  end

  def show_children_sections(assigns, section) do
    sections = LatexConfigs.list_section_children(section)
      |> Enum.map(&(LatexConfigs.change_section(&1)))
    ~L"""
    SUB
    <%= for section <- sections do %>
      <%= f = form_for section, "#", [phx_change: :update_section] %>
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
      <section>
        <%= if length(section.data.children) > 0 do %>
          <%= show_children_sections(assigns, section.data) %>
        <% end %>
      <section>
    <% end %>
    """
  end
end
