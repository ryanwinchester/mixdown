defmodule Mixdown.UserController do
  use Mixdown.Web, :controller

  alias Mixdown.User

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => username}) do
    user = Repo.get_by!(User, username: username)
    render(conn, "show.html", user: user)
  end

end
