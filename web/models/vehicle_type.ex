defmodule TestApi.VehicleType do
  use TestApi.Web, :model

  schema "vehicle_types" do
    field :name, :string
    has_many :vehicle, TestApi.Vehicle

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
