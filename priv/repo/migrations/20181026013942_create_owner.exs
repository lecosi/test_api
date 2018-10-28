defmodule TestApi.Repo.Migrations.CreateOwner do
  use Ecto.Migration

  def change do
    create table(:owners) do
      add :identification, :string
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone_number, :string

      timestamps()
    end
  end
end
