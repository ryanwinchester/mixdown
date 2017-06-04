defmodule Mixdown.Admin.SeriesController do
  use Mixdown.Web, :controller

  alias Mixdown.Series

  def index(conn, _params) do
    series = Repo.all(Series)
    render(conn, "index.html", series: series)
  end

  def new(conn, _params) do
    changeset = Series.changeset(%Series{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"series" => series_params}) do
    changeset = Series.changeset(%Series{}, series_params)

    case Repo.insert(changeset) do
      {:ok, _series} ->
        conn
        |> put_flash(:info, "Series created successfully.")
        |> redirect(to: admin_series_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    series = Repo.get!(Series, id)
    render(conn, "show.html", series: series)
  end

  def edit(conn, %{"id" => id}) do
    series = Repo.get!(Series, id)
    changeset = Series.changeset(series)
    render(conn, "edit.html", series: series, changeset: changeset)
  end

  def update(conn, %{"id" => id, "series" => series_params}) do
    series = Repo.get!(Series, id)
    changeset = Series.changeset(series, series_params)

    case Repo.update(changeset) do
      {:ok, series} ->
        conn
        |> put_flash(:info, "Series updated successfully.")
        |> redirect(to: admin_series_path(conn, :index, series))
      {:error, changeset} ->
        render(conn, "edit.html", series: series, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    series = Repo.get!(Series, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(series)

    conn
    |> put_flash(:info, "Series deleted successfully.")
    |> redirect(to: admin_series_path(conn, :index))
  end
end
