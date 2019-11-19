defmodule Fatex.LatexConfigs.Model do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.LatexConfigs.Step
  alias Fatex.Accounts.User
  alias Fatex.Accounts.SharedModel

  schema "models" do
    field :name, :string

    belongs_to(:user, User)
    has_many(:steps, Step)
    has_many(:shared_models, SharedModel) 

    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
