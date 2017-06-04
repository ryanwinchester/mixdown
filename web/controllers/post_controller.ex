defmodule Mixdown.PostController do
  use Mixdown.Web, :controller

  alias Mixdown.Post

  plug :put_layout, "home.html"

  def index(conn, _params) do
    redirect(conn, to: "/")
  end

  def show(conn, %{"id" => slug}) do
    post =
      Post
      |> Repo.get_by(slug: slug, is_published: true)
      |> Repo.preload([:user, :category, :tags])
      |> Repo.preload(series: :posts)

    render(conn, "show.html", post: post)
  end

end
