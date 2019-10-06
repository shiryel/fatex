defmodule Fatex.LatexConfigsTest do
  use Fatex.DataCase

  alias Fatex.LatexConfigs

  describe "models" do
    alias Fatex.LatexConfigs.Model

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def model_fixture(attrs \\ %{}) do
      {:ok, model} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LatexConfigs.create_model()

      model
    end

    test "list_models/0 returns all models" do
      model = model_fixture()
      assert LatexConfigs.list_models() == [model]
    end

    test "get_model!/1 returns the model with given id" do
      model = model_fixture()
      assert LatexConfigs.get_model!(model.id) == model
    end

    test "create_model/1 with valid data creates a model" do
      assert {:ok, %Model{} = model} = LatexConfigs.create_model(@valid_attrs)
      assert model.name == "some name"
    end

    test "create_model/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LatexConfigs.create_model(@invalid_attrs)
    end

    test "update_model/2 with valid data updates the model" do
      model = model_fixture()
      assert {:ok, %Model{} = model} = LatexConfigs.update_model(model, @update_attrs)
      assert model.name == "some updated name"
    end

    test "update_model/2 with invalid data returns error changeset" do
      model = model_fixture()
      assert {:error, %Ecto.Changeset{}} = LatexConfigs.update_model(model, @invalid_attrs)
      assert model == LatexConfigs.get_model!(model.id)
    end

    test "delete_model/1 deletes the model" do
      model = model_fixture()
      assert {:ok, %Model{}} = LatexConfigs.delete_model(model)
      assert_raise Ecto.NoResultsError, fn -> LatexConfigs.get_model!(model.id) end
    end

    test "change_model/1 returns a model changeset" do
      model = model_fixture()
      assert %Ecto.Changeset{} = LatexConfigs.change_model(model)
    end
  end
end
