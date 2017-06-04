defmodule Mixdown.SeriesController do
  use Mixdown.Web, :controller

  alias Mixdown.Series
  alias Mixdown.Post
  alias Ecto.Changeset

  plug :put_layout, "home.html"

  def index(conn, _params) do
    series = Repo.all(Series)
    render(conn, "index.html", series: series)
  end

  def show(conn, params = %{"id" => slug}) do
    series = Repo.get_by!(Series, slug: slug)

    page =
      Post
      |> Post.published()
      |> Post.by_series(series)
      |> order_by(asc: :series_priority)
      |> Repo.paginate(params)

    render(conn, "show.html", series: series, page: page)
  end
end
