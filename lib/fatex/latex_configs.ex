defmodule Fatex.LatexConfigs do
  @moduledoc """
  The LatexConfigs context.
  """
  import Ecto.Query, warn: false
  alias Fatex.Repo
  alias Fatex.Accounts.SharedModel
  alias Fatex.LatexConfigs.{Model, Step, Section}

  @doc """
  ## Examples:

      iex> u = Accounts.get_user 1
      iex> with [%Model{} | _] <- list_models_from_user(u), do: :ok 
      :ok
  """
  def list_models_from_user(user) do
    shared_with_me =
      Repo.all(
        from s in SharedModel,
          where: s.user_id == ^user.id
      )
      |> Enum.map(& &1.model_id)

    Repo.all(
      from m in Model,
        where: m.user_id == ^user.id,
        or_where: m.id in ^shared_with_me
    )
  end

  @doc """
  ## Examples:

      iex> with [%Model{} | _] <- list_models_templates(), do: :ok 
      :ok
  """
  def list_models_templates() do
    Repo.all(
      from m in Model,
        where: m.is_template == true
    )
  end

  @doc """
  ## Examples:

      iex> u = Accounts.get_user 1
      iex> with [model | _] <- list_models_from_user(u),
      ...>      %Model{} <- get_model(model.id), do: :ok
      :ok
  """
  def get_model(id) do
    Repo.get(Model, id)
  end

  @doc """
  ## Examples:

      iex> u = Accounts.get_user 1
      iex> with [model | _] <- list_models_from_user(u),
      ...>      [%Step{} | _] <- list_steps_from_model(model), do: :ok
      :ok
  """
  def list_steps_from_model(model) do
    Repo.all(
      from s in Step,
        where: s.model_id == ^model.id
    )
  end

  @doc """
  ## Examples:

      iex> u = Accounts.get_user 1
      iex> with [model | _] <- list_models_from_user(u),
      ...>      [step | _] <- list_steps_from_model(model),
      ...>      %Step{} <- get_step(step.id), do: :ok
      :ok
  """
  def get_step(id) do
    Repo.get(Step, id)
  end

  @doc """
  ## Examples:

      iex> u = Accounts.get_user 1
      iex> with [model | _] <- list_models_from_user(u),
      ...>      [step | _] <- list_steps_from_model(model),
      ...>      [%Section{type: type} | _] <- list_sections_from_step(step),
      ...>      false <- type in ["template"], do: :ok
      :ok
  """
  def list_sections_from_step(step) do
    Repo.all(
      from section in Section,
        where: section.step_id == ^step.id,
        where: section.type != "template",
        order_by: [section.id]
    )
  end

  @doc """
  ## Examples:

      iex> u = Accounts.get_user 1
      iex> with [model | _] <- list_models_from_user(u),
      ...>      [step | _] <- list_steps_from_model(model),
      ...>      [%Section{type: type} | _] <- list_template_sections_from_step(step),
      ...>      true <- type in ["template"], do: :ok
      :ok
  """
  def list_template_sections_from_step(step) do
    Repo.all(
      from section in Section,
        where: section.step_id == ^step.id,
        where: section.type == "template"
    )
  end

  @doc """
  ## Examples

      iex> u = Accounts.get_user 1
      iex> with [model | _] <- list_models_from_user(u),
      ...>      [step | _] <- list_steps_from_model(model),
      ...>      [template | _] = list_template_sections_from_step(step),
      ...>      {:ok, new_template} <- clone_template_to_section_type(template, "child"),
      ...>      true <- template.id != new_template,
      ...>      true <- nil == template.step_id,
      ...>      true <- new_template.type == "child", do: :ok
      :ok

  ## WARNING:
    step_id must be nil, because the live_view load the roots with the relationship with step, and so if the step_id is given there will be a duplicate (a child and  a "root")
  """
  def clone_template_to_section_type(%Section{} = section, type)
      when type in ["root", "child", "template"] do
    # WARNING:
    # step_id must be nil, because the live_view load the roots with the relationship with step, and so if the step_id is given there will be a duplicate (a child and  a "root")
    # TODO: verify if the children is correct
    %Section{
      name: section.name,
      content: section.content,
      to_fix: section.to_fix,
      latex_name_start: section.latex_name_start,
      latex_name_end: section.latex_name_end,
      latex_start: section.latex_start,
      latex_end: section.latex_end,
      type: type,
      children: section.children,
      step_id: nil
    }
    |> Repo.insert()
  end

  def clone_section(%Section{} = section, step_id) do
    # step_id of the children must be nil, because the live_view load the roots with the relationship with step, and so if the step_id is given there will be a duplicate (a child and  a "root")
    {:ok, _new_section} =
      %Section{
        name: section.name,
        content: section.content,
        to_fix: section.to_fix,
        latex_name_start: section.latex_name_start,
        latex_name_end: section.latex_name_end,
        latex_start: section.latex_start,
        latex_end: section.latex_end,
        type: section.type,
        children: Enum.map(section.children, &clone_section(&1, nil)),
        step_id: step_id
      }
      |> Repo.insert()

    :ok
  end

  def clone_step(step, model_id) do
    {:ok, new_step} =
      %Step{name: step.name, model_id: model_id}
      |> Repo.insert()

    old_step =
      step
      |> Repo.preload(:sections)

    Enum.each(old_step.sections, &clone_section(&1, new_step.id))
    :ok
  end

  def clone_model_template(model_id, to_user_id, name) when is_integer(to_user_id) do
    # clone MODEL
    {:ok, new_model} =
      %Model{name: name, user_id: to_user_id}
      |> Repo.insert()

    File.mkdir_p!("maker/#{new_model.id}/figures")
    File.cp_r("maker/#{model_id}/figures/", "maker/#{new_model.id}/figures/")

    # clone and update STEPS
    old_model =
      get_model(model_id)
      |> Repo.preload(:steps)

    Enum.each(old_model.steps, &clone_step(&1, new_model.id))
    :ok
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

  iex> with %Ecto.Changeset{} <- change_section(%Section{}), do: :ok
  :ok
  """
  def change_section(section) do
    Section.changeset(section, %{})
  end

  @doc """
  ## Examples:

      iex> u = Accounts.get_user 1
      iex> with [model | _] <- list_models_from_user(u),
      ...>      [step | _] <- list_steps_from_model(model),
      ...>      [section | _] <- list_sections_from_step(step),
      ...>      {:ok, %Section{content: "test"}} <- 
      ...>        update_section(section, %{content: "test"}), do: :ok
      :ok
  """
  def update_section(%Section{} = section, attrs) do
    section
    |> Section.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  ## Examples:

      iex> s = Repo.get Section, 2
      iex> with [] <- list_section_children(s), do: :ok
      :ok
      iex> u = Accounts.get_user 1
      iex> with [model | _] <- list_models_from_user(u),
      ...>      [step | _] <- list_steps_from_model(model),
      ...>      [section | _] <- list_sections_from_step(step),
      ...>      {:ok, new_section} <- section_append_child(section, s),
      ...>      [%Section{} | _] <- list_section_children(new_section), do: :ok
      :ok
  """
  def list_section_children(%Section{} = section) do
    children = section.children

    Repo.all(
      from s in Section,
        where: s.id in ^children
    )
  end

  @doc """
  Add section (child) as last child in the section (father) children list

  ## Examples:

      iex> s1 = get_section 1
      iex> s2 = get_section 2
      iex> with {:ok, section} <- section_append_child(s1, s2),
      ...>      %Section{children: children} <- section,
      ...>      2 <- List.last(children), do: :ok
      :ok
  """
  def section_append_child(%Section{} = section, %Section{} = child) do
    update_section(section, %{children: section.children ++ [child.id]})
  end

  @doc """
  Add section (child) as first child in the section (father) children list

  ## Examples:

      iex> s1 = get_section 1
      iex> s2 = get_section 2
      iex> with {:ok, section} <- section_append_child(s1, s2),
      ...>      %Section{children: children} <- section,
      ...>      2 <- List.first(children), do: :ok
      :ok
  """
  def section_prepend_child(%Section{} = section, %Section{} = child) do
    update_section(section, %{children: [child.id | section.children]})
  end

  @doc """
  Append section (parent) in the parent using father children list

  ## Examples:

      iex> s1 = get_section 1
      iex> s2 = get_section 2
      iex> s3 = get_section 4
      iex> with {:ok, _father} <- section_append_child(s1, s2),
      ...>      {:ok, father} <- section_append(s2, s3),
      ...>      [2, 4] <- father.children, do: :ok
      :ok
  """
  def section_append(%Section{} = section, %Section{} = child) do
    [father | _] =
      Repo.all(
        from s in Section,
          where: ^section.id in s.children
      )

    index = Enum.find_index(father.children, &(&1 == section.id))
    new_father_children = List.insert_at(father.children, index + 1, child.id)

    update_section(father, %{children: new_father_children})
  end

  @doc """
  Prepend section (parent) in the parent using father children list

  ## Examples:

      iex> s1 = get_section 1
      iex> s2 = get_section 2
      iex> s3 = get_section 4
      iex> with {:ok, _father} <- section_append_child(s1, s2),
      ...>      {:ok, father} <- section_prepend(s2, s3),
      ...>      [4, 2] <- father.children, do: :ok
      :ok
  """
  def section_prepend(%Section{} = section, %Section{} = child) do
    [father | _] =
      Repo.all(
        from s in Section,
          where: ^section.id in s.children
      )

    index = Enum.find_index(father.children, &(&1 == section.id))
    new_father_children = List.insert_at(father.children, index, child.id)

    update_section(father, %{children: new_father_children})
  end

  @doc """
  ## Examples:

      iex> with %Section{} <- get_section(1), do: :ok
      :ok
  """
  def get_section(id) do
    Repo.get(Section, id)
  end

  @doc """
  ## Examples:

      iex> with section <- get_section(3), 
      ...>      {:ok, %Section{}} <- delete_section(section), do: :ok
      :ok
  """
  def delete_section(%Section{} = section) do
    Repo.delete(section)
  end

  @doc """
  ## Examples:

      iex> with step <- get_step(1), 
      ...>      {:ok, %Step{}} <- delete_step(step), do: :ok
      :ok
  """
  def delete_step(%Step{} = step) do
    step =
      step
      |> Repo.preload(:sections)

    Enum.each(step.sections, &delete_section/1)
    Repo.delete(step)
  end

  @doc """
  ## Examples:

      iex> with model <- get_model(1), 
      ...>      {:ok, %Model{}} <- delete_model(model), do: :ok
      :ok
  """
  def delete_model(%Model{} = model) do
    model =
      model
      |> Repo.preload(:steps)
      |> Repo.preload(:shared_models)

    Enum.each(model.steps, &delete_step/1)

    Enum.each(
      model.shared_models,
      &Fatex.Accounts.unshare_model_with(model.user_id, &1.model_id, &1.user_id)
    )

    Repo.delete(model)
  end
end
