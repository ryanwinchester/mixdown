defmodule Mixdown.PageController do
  use Mixdown.Web, :controller

  alias Mixdown.Post

  plug :put_layout, "home.html"

  def index(conn, params) do
    page =
    Post.published(Post)
    |> order_by(desc: :published_at)
    |> Repo.paginate(params)

    render conn, "index.html", page: page
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end

end
