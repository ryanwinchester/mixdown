defmodule Mixdown.SessionController do
  use Mixdown.Web, :controller

  alias Mixdown.Auth

  plug :put_layout, "auth.html"

  @doc """
  Show the login screen.
  """
  def new(conn, _params) do
    render(conn, "login.html")
  end

  @doc """
  Authenticate a user.
  """
  def create(conn, %{"email" => email, "password" => pass}) do
    case Auth.attempt(conn, email, pass) do
      {:ok, conn, user} ->
        conn
        |> assign(:current_user, user)
        |> put_flash(:info, "Welcome back!")
        |> render("loggedin.html")
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("login.html")
    end
  end

  @doc """
  Log out the user.
  """
  def delete(conn, _params) do
    conn
    |> Auth.logout
    |> put_flash(:info, "You have been logged out.")
    |> redirect(to: admin_dashboard_path(conn, :index))
  end

  @doc """
  Handle a request from an unauthenticcated user.
  """
  def unauthenticated(conn, _params) do
    redirect(conn, to: session_path(conn, :new))
  end
end
