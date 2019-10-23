defmodule FatexWeb.SectionView do
  use FatexWeb, :view
  alias Fatex.LatexConfigs

  @doc """
  Show the children of a section and make a recursiion to show the children of the children
  """
  def list_children_sections(section) do
    LatexConfigs.list_section_children(section)
      |> Enum.map(&(LatexConfigs.change_section(&1)))
  end

end
