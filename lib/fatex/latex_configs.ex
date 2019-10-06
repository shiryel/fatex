defmodule Fatex.LatexConfigs do
  @moduledoc """
  The LatexConfigs context.
  """

  import Ecto.Query, warn: false
  alias Fatex.Repo

  alias Fatex.LatexConfigs.{Model, Step, Section}

  @doc """
		Examples:
  	iex> u = Fatex.Accounts.get_user! 1
			%Fatex.Accounts.User{...}
		iex> list_models_from_user u
			%Fatex.LatexConfigs.Model{...}
  """
  def list_models_from_user(user) do
    from(m in Model,
      where: m.user_id == ^user.id
    )
    |> Repo.all()
  end

  def list_steps_from_model(model) do
    from(s in Step,
      where: s.model_id == ^model.id
    )
    |> Repo.all()
  end

  def list_sections_from_step(step) do
    from(section in Section,
      where: section.step_id == ^step.id
    )
    |> Repo.all()
  end

  def update_section(%Section{} = section, attrs) do
    section
    |> Section.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Default model for fatec

  Define all steps and default sections needed to a TG
  """
  def new_fatec_model(user, name) do
    %Model{
      user_id: user.id,
      name: name,
      steps: [
        %Step{
          name: "Informações",
          sections: [
            %Section{
              name: "Explicação inicial",
              content: "",
              type: "text"
            }
          ]
        },
        %Step{
          name: "Introdução",
          sections: [
            %Section{
              name: "Explicação inicial",
              content: "",
              type: "text"
            }
          ]
        },
        %Step{
          name: "Desenvolvimento",
          sections: [
            %Section{
              name: "Explicação inicial",
              content: "",
              type: "text"
            }
          ]
        },
        %Step{
          name: "Testes e Resultados",
          sections: [
            %Section{
              name: "Testes",
              content: "",
              type: "text"
            },
            %Section{
              name: "Resultados",
              content: "",
              type: "text"
            }
          ]
        },
        %Step{
          name: "Discussão e Conclusão",
          sections: [
            %Section{
              name: "Discussão",
              content: "",
              type: "text"
            },
            %Section{
              name: "Conclusão",
              content: "",
              type: "text"
            }
          ]
        },
        %Step{
          name: "Resumo",
          sections: [
            %Section{
              name: "Resumo",
              content: "",
              type: "text"
            },
            %Section{
              name: "Abstract",
              content: "",
              type: "text"
            }
          ]
        }
      ]
    }
    |> Repo.insert!()
  end
end
