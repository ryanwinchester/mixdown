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
    plug Guardian.Plug.EnsureAuthenticated,
      handler: Provisioner.SessionController
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mixdown do
    pipe_through [:browser, :browser_session]

    get "/", PageController, :index
    resources "/posts", PostController, only: [:index, :show]
    resources "/users", UserController, only: [:index, :show]
  end

  scope "/admin", Mixdown.Admin do
    pipe_through [:browser, :browser_session] # TODO: add :browser_auth

    resources "/posts", PostController, as: :admin_post, except: [:show]
    resources "/users", UserController, as: :admin_user, except: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Mixdown do
  #   pipe_through :api
  # end
end
