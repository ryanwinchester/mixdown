defmodule Mixdown.Admin.SeriesControllerTest do
  use Mixdown.ConnCase

  alias Mixdown.Series
  @valid_attrs %{description: "some content", name: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, series_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing series"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, series_path(conn, :new)
    assert html_response(conn, 200) =~ "New series"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, series_path(conn, :create), series: @valid_attrs
    assert redirected_to(conn) == series_path(conn, :index)
    assert Repo.get_by(Series, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, series_path(conn, :create), series: @invalid_attrs
    assert html_response(conn, 200) =~ "New series"
  end

  test "shows chosen resource", %{conn: conn} do
    series = Repo.insert! %Series{}
    conn = get conn, series_path(conn, :show, series)
    assert html_response(conn, 200) =~ "Show series"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, series_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    series = Repo.insert! %Series{}
    conn = get conn, series_path(conn, :edit, series)
    assert html_response(conn, 200) =~ "Edit series"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    series = Repo.insert! %Series{}
    conn = put conn, series_path(conn, :update, series), series: @valid_attrs
    assert redirected_to(conn) == series_path(conn, :show, series)
    assert Repo.get_by(Series, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    series = Repo.insert! %Series{}
    conn = put conn, series_path(conn, :update, series), series: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit series"
  end

  test "deletes chosen resource", %{conn: conn} do
    series = Repo.insert! %Series{}
    conn = delete conn, series_path(conn, :delete, series)
    assert redirected_to(conn) == series_path(conn, :index)
    refute Repo.get(Series, series.id)
  end
end
