defmodule Mixdown.PageController do
  use Mixdown.Web, :controller

  alias Mixdown.Post

  plug :put_layout, "home.html"

  def index(conn, params) do
    page =
      Post
      |> where([p], p.is_published == true)
      |> order_by(desc: :published_at)
      |> preload([:user, :tags])
      |> Repo.paginate(params)

    render conn, "index.html",
      posts: page.entries,
      page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_entries: page.total_entries
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end

end
