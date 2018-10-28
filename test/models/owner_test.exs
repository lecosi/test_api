defmodule TestApi.OwnerTest do
  use TestApi.ModelCase

  alias TestApi.Owner

  @valid_attrs %{email: "some email", first_name: "some first_name", identification: "some identification", last_name: "some last_name", phone_number: "some phone_number"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Owner.changeset(%Owner{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Owner.changeset(%Owner{}, @invalid_attrs)
    refute changeset.valid?
  end
end
