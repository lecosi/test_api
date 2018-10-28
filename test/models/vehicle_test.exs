defmodule TestApi.VehicleTest do
  use TestApi.ModelCase

  alias TestApi.Vehicle

  @valid_attrs %{vehicle_plate: "some vehicle_plate"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Vehicle.changeset(%Vehicle{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Vehicle.changeset(%Vehicle{}, @invalid_attrs)
    refute changeset.valid?
  end
end
