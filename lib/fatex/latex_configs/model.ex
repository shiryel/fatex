defmodule Fatex.LatexConfigs.Model do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.LatexConfigs.Step
  alias Fatex.Accounts.User
  alias Fatex.Accounts.SharedModel

  schema "models" do
    field :name, :string
    field :is_template, :boolean, default: false

    belongs_to(:user, User)
    has_many(:steps, Step)
    has_many(:shared_models, SharedModel) 

    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name, :is_template])
    |> validate_required([:name, :is_template])
  end
end
