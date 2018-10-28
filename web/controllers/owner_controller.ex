defmodule TestApi.OwnerController do
  use TestApi.Web, :controller

  alias TestApi.Owner

  def index(conn, _params) do
    owners = Repo.all(Owner)
    render(conn, "index.json", owners: owners)
  end

  def create(conn, %{"owner" => owner_params}) do
    changeset = Owner.changeset(%Owner{}, owner_params)

    case Repo.insert(changeset) do
      {:ok, owner} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", owner_path(conn, :show, owner))
        |> render("show.json", owner: owner)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TestApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    owner = Repo.get!(Owner, id)
    render(conn, "show.json", owner: owner)
  end

  def update(conn, %{"id" => id, "owner" => owner_params}) do
    owner = Repo.get!(Owner, id)
    changeset = Owner.changeset(owner, owner_params)

    case Repo.update(changeset) do
      {:ok, owner} ->
        render(conn, "show.json", owner: owner)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TestApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    owner = Repo.get!(Owner, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(owner)

    send_resp(conn, :no_content, "")
  end
end
