defmodule TestApi.Owner do
  use TestApi.Web, :model

  schema "owners" do
    field :identification, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone_number, :string
    has_many :vehicle, TestApi.Vehicle

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:identification, :first_name, :last_name, :email, :phone_number])
    |> validate_required([:identification, :first_name, :last_name, :email, :phone_number])
  end
end
