defmodule Mixdown.TagControllerTest do
  use Mixdown.ConnCase

  alias Mixdown.Tag
  @valid_attrs %{description: "some content", name: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tag_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tags"
  end

  test "shows chosen resource", %{conn: conn} do
    tag = Repo.insert! %Tag{}
    conn = get conn, tag_path(conn, :show, tag)
    assert html_response(conn, 200) =~ "Show tag"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, tag_path(conn, :show, -1)
    end
  end

end
