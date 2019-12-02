defmodule Render.Core.DataHandler do
  @moduledoc """
  Handle the model's setps's sections data

  The `Render.Core.Parser.exec/1` is used in the name and the content
  """
  alias Fatex.LatexConfigs

  @doc """
  Returns a list with the strins of the sections in order from the DB
  """
  @spec concat_all(integer) :: [bitstring]
  def concat_all(model_id) do
    get_all(model_id)
    |> Enum.flat_map(fn x ->
      Enum.map(x, &make_latex_of_section/1)
    end)

    # Concat is two lists, one for the steps and other for the section of the step
    # The steps is concatened with the flat_map
    # That leaves one list with all sections sorted based on DB
  end

  # Get all in the order of the DB
  defp get_all(model_id) do
    LatexConfigs.get_model(model_id)
    |> LatexConfigs.list_steps_from_model()
    |> Enum.map(&LatexConfigs.list_sections_from_step/1)
  end

  defp string_any(str) do
    if String.length(str) > 0 do
      true
    else
      false
    end
  end

  # Em tabelas root o nome é ignorado caso latex_name_start ou latex_name_end não for contiverem algo, em tabelas filhas o nome é usado com o begin{NAME} caso não houver os dados acima
  defp get_section_name(section) do
    case section.type do
      "root" ->
        if string_any(section.latex_name_start) ||
             string_any(section.latex_name_end) do
          """
          #{section.latex_name_start}
          #{section.name}
          #{section.latex_name_end}
          """
        else
          ""
        end

      _ ->
        if string_any(section.latex_name_start) ||
             string_any(section.latex_name_end) do
          """
          #{section.latex_name_start}
          #{section.name}
          #{section.latex_name_end}
          """
        else
          name =
            section.name
            |> Render.Core.Parser.exec()

          "begin{#{name}}"
        end
    end
  end

  # get content, and apply the parser to section.content
  defp get_section_content(section) do
    content = 
      section.content
      |> Render.Core.Parser.exec()

    """
    #{section.latex_start}
    #{content}
    #{section.latex_end}
    """
  end

  defp load_child(child_id) do
    LatexConfigs.get_section(child_id)
  end

  defp make_latex_of_section(section) do
    """
    #{get_section_name(section)}
    #{get_section_content(section)}
    #{
      Enum.map(section.children, fn c ->
        load_child(c)
        |> make_latex_of_section()
      end)
    }
    """
  end
end
