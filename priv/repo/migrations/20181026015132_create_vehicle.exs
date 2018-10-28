defmodule TestApi.Repo.Migrations.CreateVehicle do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :vehicle_plate, :string
      add :brand, :string
      add :vehicle_type, :string
      add :owner, :string

      timestamps()
    end
  end
end
