defmodule FatexWeb.StepView do
  use FatexWeb, :view
  alias Fatex.LatexConfigs

  @doc """
  Fallback to sections when step is nil
  """
  def show_sections_from_step(assigns, nil) do
    ~L"""
    Escolha uma opção da lista acima
    """
  end

  @doc """
  Show the root section from a step and your children (rose tree) with the show_children_sections/2
  """
  def show_sections_from_step(assigns, step) do
    sections = LatexConfigs.list_sections_from_step(step)
      |> Enum.map(&(LatexConfigs.change_section(&1)))
    ~L"""
    <%= for section <- sections do %>
      <%= show_section(assigns, section) %>
      <%= section_button(assigns, section, "append_child", "Adicionar Filho") %>
    <section>
      <%= if length(section.data.children) > 0 do %>
        <%= show_children_sections(assigns, section.data) %>
      <% end %>
    <section>
    <% end %>
    """
  end

  @doc """
  Show the children of a section and make a recursiion to show the children of the children
  """
  def show_children_sections(assigns, section) do
    sections = LatexConfigs.list_section_children(section)
      |> Enum.map(&(LatexConfigs.change_section(&1)))
    ~L"""
    SUB
    <%= for section <- sections do %>
      <%= show_section(assigns, section) %>
      <section>
        <%= if length(section.data.children) > 0 do %>
          <%= show_children_sections(assigns, section.data) %>
        <% end %>
      <section>
    <% end %>
    """
  end

  defp section_button(assigns, section, click, nome) do
    ~L"""
      <%= if @to_add != nil do %>
        <div phx-click="<%= click %>" phx-value-to_add="<%= @to_add %>" phx-value-section_id="<%= section.data.id %>" class="column button">
          <%= nome %>
        </div>
      <% end %>
    """
  end

  defp show_section(assigns, section) do
    ~L"""
      <%= f = form_for section, "#", [phx_change: :update_section] %>
        <%= hidden_input f, :id %>
        <%= hidden_input f, :type %>

        <section>
          <div>
            <%= label f, :name %>
          </div>
          <div>
            <%= text_input f, :name %>
            <%= error_tag f, :name %>
          </div>
        </section>

        <section>
          <div>
            <%= label f, :content %>
          </div>
          <div>
            <%= textarea f, :content %>
            <%= error_tag f, :content %>
          </div>
        </section>
      </form>
    """
  end

end
