defmodule TestApi.Router do
  use TestApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TestApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/vehicles", VehicleController, :index
    get "/vehicle/new", VehicleController, :new
    get "/owners", OwnerController, :index
    get "/owner/new", OwnerController, :new
  end

  scope "/api", TestApi do
    pipe_through :api
    resources "/owners", OwnerController, except: [:new, :edit]
  end

  scope "/api", TestApi do
    pipe_through :api
    resources "/vehicles", VehicleController, except: [:new, :edit]
  end

  scope "/api", TestApi do
    pipe_through :api
    resources "/vehicle_types", VehicleTypeController, except: [:new, :edit]
  end

  scope "/api", TestApi do
    pipe_through :api
    resources "/brands", BrandController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestApi do
  #   pipe_through :api
  # end
end
