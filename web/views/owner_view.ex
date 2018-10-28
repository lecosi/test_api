defmodule TestApi.OwnerView do
  use TestApi.Web, :view

  def render("index.json", %{owners: owners}) do
    %{data: render_many(owners, TestApi.OwnerView, "owner.json")}
  end

  def render("show.json", %{owner: owner}) do
    %{data: render_one(owner, TestApi.OwnerView, "owner.json")}
  end

  def render("owner.json", %{owner: owner}) do
    %{id: owner.id,
      identification: owner.identification,
      first_name: owner.first_name,
      last_name: owner.last_name,
      email: owner.email,
      phone_number: owner.phone_number}
  end
end
