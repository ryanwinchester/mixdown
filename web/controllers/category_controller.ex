defmodule Mixdown.CategoryController do
  use Mixdown.Web, :controller

  alias Mixdown.Category
  alias Mixdown.Post

  plug :put_layout, "home.html"

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.html", categories: categories)
  end

  def show(conn, params = %{"id" => slug}) do
    category = Repo.get_by!(Category, slug: slug)

    page =
      Post
      |> Post.published()
      |> Post.by_category(category)
      |> order_by(desc: :published_at)
      |> Repo.paginate(params)

    render(conn, "show.html", category: category, page: page)
  end
end
