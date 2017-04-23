defmodule Mixdown.CategoryTest do
  use Mixdown.ModelCase

  alias Mixdown.Category

  @valid_attrs %{description: "some content", name: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
  end
end
