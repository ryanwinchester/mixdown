defmodule Mixdown.Router do
  use Mixdown.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Mixdown.Plugs.LoadUser
  end

  pipeline :browser_auth do
    plug Guardian.Plug.EnsureAuthenticated, handler: Mixdown.SessionController
    plug Mixdown.Plugs.LoadUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mixdown do
    pipe_through [:browser, :browser_session]

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/contact", PageController, :contact
    resources "/posts", PostController, only: [:index, :show]
    resources "/tags", TagController, only: [:index, :show]
    resources "/categories", CategoryController, only: [:index, :show]
    resources "/series", SeriesController, only: [:index, :show]
    resources "/users", UserController, only: [:index, :show]
  end

  scope "/auth", Mixdown do
    pipe_through [:browser, :browser_session]

    get "/login", SessionController, :new, as: :session
    post "/login", SessionController, :create, as: :session
    delete "/", SessionController, :delete, as: :session
    get "/logout", SessionController, :delete, as: :logout
  end

  scope "/admin", Mixdown.Admin, as: :admin do
    pipe_through [:browser, :browser_session, :browser_auth]

    get "/", DashboardController, :index

    resources "/posts", PostController, except: [:show]
    resources "/tags", TagController, except: [:show]
    resources "/categories", CategoryController, except: [:show]
    resources "/series", SeriesController, except: [:show]
    resources "/users", UserController, except: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Mixdown do
  #   pipe_through :api
  # end
end
