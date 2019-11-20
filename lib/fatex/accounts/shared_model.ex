defmodule Fatex.Accounts.SharedModel do
  use Ecto.Schema
  alias Fatex.Accounts.User
  alias Fatex.LatexConfigs.Model

  @primary_key false
  schema "shared_models" do
    belongs_to(:user, User, primary_key: true) 
    belongs_to(:model, Model, primary_key: true) 

    timestamps()
  end

end
