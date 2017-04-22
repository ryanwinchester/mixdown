defmodule Mixdown.TagController do
  use Mixdown.Web, :controller

  alias Mixdown.Tag

  plug :put_layout, "home.html"

  def index(conn, _params) do
    tags = Repo.all(Tag)
    render(conn, "index.html", tags: tags)
  end

  def show(conn, %{"id" => slug}) do
    tag = Repo.get_by!(Tag, slug: slug) |> Repo.preload(posts: [:user])
    render(conn, "show.html", tag: tag)
  end

end
