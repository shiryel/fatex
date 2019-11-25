defmodule Fatex.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    ## ACCOUNTS ##
    
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

    ## LATEX CONFIGS ##
    #
    create table(:models) do
      add :name, :string
      add :is_template, :boolean
      add :user_id, references(:users), on_delete: :delete_all

      timestamps()
    end

    create table(:steps) do
      add :name, :string
      add :model_id, references(:models), on_delete: :delete_all

      timestamps()
    end

    create table(:sections) do
      add :name, :text
      add :content, :text
      add :to_fix, :text

      # latex to add on start and end of the name and content
      add :latex_name_start, :text
      add :latex_name_end, :text
      add :latex_start, :text
      add :latex_end, :text

      # used by the code to change the behavior of the content
      add :type, :string

      # recursion os sections to mont on screen
      add :children, {:array, :integer}

      add :step_id, references(:steps), on_delete: :delete_all

      timestamps()
    end

    # Table for define who can access the model 
    # (excluding the use who created the model,
    # he is in the models table)
    create table(:shared_models, primary_key: false) do
      add :user_id, references(:users), primary_key: true, on_delete: :delete_all
      add :model_id, references(:models), primary_key: true, on_delete: :delete_all

      timestamps()
    end
  end
end
