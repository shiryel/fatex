defmodule Fatex.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    ## ACCOUNTS ##
    
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password, :string

      timestamps()
    end

    ## LATEX CONFIGS ##
    #
    create table(:models) do
      add :name, :string
      add :user_id, references(:users)

      timestamps()
    end

    create table(:steps) do
      add :name, :string
      add :model_id, references(:models)

      timestamps()
    end

    create table(:sections) do
      add :name, :string
      add :content, :string

      # used by the code to change the behavior of the content
      add :type, :string

      # recursion os sections to mont on screen
      add :child_id, :integer
      add :pos_child_id, :integer
      add :pre_child_id, :integer

      add :step_id, references(:steps)

      timestamps()
    end

  end
end
