defmodule Mixdown.TagController do
  use Mixdown.Web, :controller

  alias Mixdown.Post
  alias Mixdown.Tag

  plug :put_layout, "home.html"

  def index(conn, _params) do
    tags = Repo.all(Tag)
    render(conn, "index.html", tags: tags)
  end

  def show(conn, params = %{"id" => slug}) do
    tag = Repo.get_by!(Tag, slug: slug)

    page =
      Post
      |> Post.published()
      |> Post.by_tag(tag)
      |> Repo.paginate(params)

    render(conn, "show.html", tag: tag, page: page)
  end
end
