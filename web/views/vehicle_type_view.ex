defmodule TestApi.VehicleTypeView do
  use TestApi.Web, :view

  def render("index.json", %{vehicle_types: vehicle_types}) do
    %{data: render_many(vehicle_types, TestApi.VehicleTypeView, "vehicle_type.json")}
  end

  def render("show.json", %{vehicle_type: vehicle_type}) do
    %{data: render_one(vehicle_type, TestApi.VehicleTypeView, "vehicle_type.json")}
  end

  def render("vehicle_type.json", %{vehicle_type: vehicle_type}) do
    %{id: vehicle_type.id,
      name: vehicle_type.name}
  end
end
