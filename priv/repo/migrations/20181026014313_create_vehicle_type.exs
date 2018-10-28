defmodule TestApi.Repo.Migrations.CreateVehicleType do
  use Ecto.Migration

  def change do
    create table(:vehicle_types) do
      add :name, :string

      timestamps()
    end
  end
end
