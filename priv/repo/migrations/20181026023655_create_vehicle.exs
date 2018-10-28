defmodule TestApi.Repo.Migrations.CreateVehicle do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :vehicle_plate, :string
      add :brand_id, references(:brands, on_delete: :nothing)
      add :vehicle_type_id, references(:vehicle_types, on_delete: :nothing)
      add :owner_id, references(:owners, on_delete: :nothing)

      timestamps()
    end

    create index(:vehicles, [:brand_id])
    create index(:vehicles, [:vehicle_type_id])
    create index(:vehicles, [:owner_id])
  end
end
