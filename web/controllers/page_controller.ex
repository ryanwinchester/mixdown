defmodule Mixdown.PageController do
  use Mixdown.Web, :controller

  alias Mixdown.Post

  plug :put_layout, "home.html"

  def index(conn, _params) do
    posts = Repo.all(Post) |> Repo.preload(:user)
    render conn, "index.html", posts: posts
  end

end
