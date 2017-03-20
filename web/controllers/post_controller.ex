defmodule Mixdown.PostController do
  use Mixdown.Web, :controller

  alias Mixdown.Post

  plug :put_layout, "home.html"

  def index(conn, _params) do
    posts = Repo.all(from p in Post, where: p.is_published == true) |> Repo.preload(:user)
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => slug}) do
    post = Repo.get_by(Post, slug: slug, is_published: true) |> Repo.preload(:user)
    render(conn, "show.html", post: post)
  end

end
