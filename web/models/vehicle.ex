defmodule TestApi.Vehicle do
  use TestApi.Web, :model

  schema "vehicles" do
    field :vehicle_plate, :string
    belongs_to :brand, TestApi.Brand, foreign_key: :brand_id
    belongs_to :vehicle_type, TestApi.VehicleType, foreign_key: :vehicle_type_id
    belongs_to :owner, TestApi.Owner, foreign_key: :owner_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:vehicle_plate, :brand_id, :vehicle_type_id, :owner_id])
    |> validate_required([:vehicle_plate, :brand_id, :vehicle_type_id, :owner_id])
  end
end
