defmodule TestApi.VehicleTypeTest do
  use TestApi.ModelCase

  alias TestApi.VehicleType

  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = VehicleType.changeset(%VehicleType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = VehicleType.changeset(%VehicleType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
