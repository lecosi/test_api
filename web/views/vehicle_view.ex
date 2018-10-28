defmodule TestApi.VehicleView do
  use TestApi.Web, :view

  def render("index.json", %{vehicles: vehicles}) do
    %{data: render_many(vehicles, TestApi.VehicleView, "vehicle.json")}
  end

  def render("show.json", %{vehicle: vehicle}) do
    %{data: render_one(vehicle, TestApi.VehicleView, "vehicle.json")}
  end

  def render("vehicle.json", %{vehicle: vehicle}) do
    %{id: vehicle.id,
      vehicle_plate: vehicle.vehicle_plate,
      brand_id: vehicle.brand_id,
      vehicle_type_id: vehicle.vehicle_type_id,
      owner_id: vehicle.owner_id}
  end
end
