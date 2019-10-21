defmodule Fatex.LatexConfigs.Section do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.LatexConfigs.Step

  schema "sections" do
    field :name, :string
    field :content, :string

    # root | child | template
    field :type, :string

    field :children, {:array, :integer}, default: []

    belongs_to(:step, Step)

    timestamps()
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, ~w[name content type children]a)
    |> validate_required(~w[name type]a)
  end
  
end
