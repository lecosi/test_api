defmodule TestApi.VehicleTypeController do
  use TestApi.Web, :controller

  alias TestApi.VehicleType

  def index(conn, _params) do
    vehicle_types = Repo.all(VehicleType)
    render(conn, "index.json", vehicle_types: vehicle_types)
  end

  def create(conn, %{"vehicle_type" => vehicle_type_params}) do
    changeset = VehicleType.changeset(%VehicleType{}, vehicle_type_params)

    case Repo.insert(changeset) do
      {:ok, vehicle_type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", vehicle_type_path(conn, :show, vehicle_type))
        |> render("show.json", vehicle_type: vehicle_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TestApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vehicle_type = Repo.get!(VehicleType, id)
    render(conn, "show.json", vehicle_type: vehicle_type)
  end

  def update(conn, %{"id" => id, "vehicle_type" => vehicle_type_params}) do
    vehicle_type = Repo.get!(VehicleType, id)
    changeset = VehicleType.changeset(vehicle_type, vehicle_type_params)

    case Repo.update(changeset) do
      {:ok, vehicle_type} ->
        render(conn, "show.json", vehicle_type: vehicle_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TestApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vehicle_type = Repo.get!(VehicleType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(vehicle_type)

    send_resp(conn, :no_content, "")
  end
end
