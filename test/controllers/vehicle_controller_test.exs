defmodule TestApi.VehicleControllerTest do
  use TestApi.ConnCase

  alias TestApi.Vehicle
  @valid_attrs %{vehicle_plate: "some vehicle_plate"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, vehicle_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    vehicle = Repo.insert! %Vehicle{}
    conn = get conn, vehicle_path(conn, :show, vehicle)
    assert json_response(conn, 200)["data"] == %{"id" => vehicle.id,
      "vehicle_plate" => vehicle.vehicle_plate,
      "brand_id" => vehicle.brand_id,
      "vehicle_type_id" => vehicle.vehicle_type_id,
      "owner_id" => vehicle.owner_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, vehicle_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, vehicle_path(conn, :create), vehicle: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Vehicle, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, vehicle_path(conn, :create), vehicle: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    vehicle = Repo.insert! %Vehicle{}
    conn = put conn, vehicle_path(conn, :update, vehicle), vehicle: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Vehicle, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    vehicle = Repo.insert! %Vehicle{}
    conn = put conn, vehicle_path(conn, :update, vehicle), vehicle: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    vehicle = Repo.insert! %Vehicle{}
    conn = delete conn, vehicle_path(conn, :delete, vehicle)
    assert response(conn, 204)
    refute Repo.get(Vehicle, vehicle.id)
  end
end
