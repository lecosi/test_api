defmodule TestApi.VehicleTypeControllerTest do
  use TestApi.ConnCase

  alias TestApi.VehicleType
  @valid_attrs %{name: "some name"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, vehicle_type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    vehicle_type = Repo.insert! %VehicleType{}
    conn = get conn, vehicle_type_path(conn, :show, vehicle_type)
    assert json_response(conn, 200)["data"] == %{"id" => vehicle_type.id,
      "name" => vehicle_type.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, vehicle_type_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, vehicle_type_path(conn, :create), vehicle_type: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(VehicleType, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, vehicle_type_path(conn, :create), vehicle_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    vehicle_type = Repo.insert! %VehicleType{}
    conn = put conn, vehicle_type_path(conn, :update, vehicle_type), vehicle_type: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(VehicleType, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    vehicle_type = Repo.insert! %VehicleType{}
    conn = put conn, vehicle_type_path(conn, :update, vehicle_type), vehicle_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    vehicle_type = Repo.insert! %VehicleType{}
    conn = delete conn, vehicle_type_path(conn, :delete, vehicle_type)
    assert response(conn, 204)
    refute Repo.get(VehicleType, vehicle_type.id)
  end
end
