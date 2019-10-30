defmodule FatexWeb.SectionView do
  use FatexWeb, :view
  alias Fatex.LatexConfigs

  @doc """
  Show the children of a section and make a recursiion to show the children of the children
  """
  def change_section(section) do
    LatexConfigs.change_section(section)
  end

end
