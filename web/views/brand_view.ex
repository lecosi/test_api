defmodule TestApi.BrandView do
  use TestApi.Web, :view

  def render("index.json", %{brands: brands}) do
    %{data: render_many(brands, TestApi.BrandView, "brand.json")}
  end

  def render("show.json", %{brand: brand}) do
    %{data: render_one(brand, TestApi.BrandView, "brand.json")}
  end

  def render("brand.json", %{brand: brand}) do
    %{id: brand.id,
      name: brand.name}
  end
end
