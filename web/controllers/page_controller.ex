defmodule TestApi.PageController do
  use TestApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
