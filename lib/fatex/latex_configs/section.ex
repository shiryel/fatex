defmodule Fatex.LatexConfigs.Section do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.LatexConfigs.Step

  schema "sections" do
    field :name, :string, default: ""
    field :content, :string, default: ""
    field :to_fix, :string, default: ""
    field :latex_name_start, :string, default: ""
    field :latex_name_end, :string, default: ""
    field :latex_start, :string, default: ""
    field :latex_end, :string, default: ""

    # root | child | template
    field :type, :string

    field :children, {:array, :integer}, default: []

    belongs_to(:step, Step)

    timestamps()
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, ~w[name content to_fix type children]a)
    |> validate_required(~w[name type]a)
  end
  
end
