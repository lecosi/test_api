defmodule TestApi.OwnerControllerTest do
  use TestApi.ConnCase

  alias TestApi.Owner
  @valid_attrs %{email: "some email", first_name: "some first_name", identification: "some identification", last_name: "some last_name", phone_number: "some phone_number"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, owner_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    owner = Repo.insert! %Owner{}
    conn = get conn, owner_path(conn, :show, owner)
    assert json_response(conn, 200)["data"] == %{"id" => owner.id,
      "identification" => owner.identification,
      "first_name" => owner.first_name,
      "last_name" => owner.last_name,
      "email" => owner.email,
      "phone_number" => owner.phone_number}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, owner_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, owner_path(conn, :create), owner: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Owner, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, owner_path(conn, :create), owner: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    owner = Repo.insert! %Owner{}
    conn = put conn, owner_path(conn, :update, owner), owner: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Owner, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    owner = Repo.insert! %Owner{}
    conn = put conn, owner_path(conn, :update, owner), owner: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    owner = Repo.insert! %Owner{}
    conn = delete conn, owner_path(conn, :delete, owner)
    assert response(conn, 204)
    refute Repo.get(Owner, owner.id)
  end
end
