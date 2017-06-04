defmodule Mixdown.Admin.PostView do
  use Mixdown.Web, :view

  import Ecto.Query, only: [from: 2]

  alias Ecto.Changeset
  alias Mixdown.Category
  alias Mixdown.CoverPhoto
  alias Mixdown.Photo
  alias Mixdown.Post
  alias Mixdown.Repo
  alias Mixdown.Tag
  alias Mixdown.Series

  def cover_photo_url(changeset) do
    CoverPhoto.url({Changeset.get_field(changeset, :cover_photo), Changeset.apply_changes(changeset)})
  end

  def photo_url(changeset) do
    Photo.url({Changeset.get_field(changeset, :photo), Changeset.apply_changes(changeset)})
  end

  def all_categories() do
    Repo.all(from c in Category, select: {c.name, c.id}, order_by: c.name)
  end

  def all_tags() do
    Repo.all(from t in Tag, select: {t.name, t.id}, order_by: t.name)
  end

  def all_series() do
    Repo.all(from s in Series, select: {s.name, s.id}, order_by: s.name)
  end

  def selected_tags(changeset) do
    Enum.map(changeset.data.tags, &(&1.id))
  end

end
