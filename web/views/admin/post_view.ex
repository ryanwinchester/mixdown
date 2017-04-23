defmodule Mixdown.Admin.PostView do
  use Mixdown.Web, :view

  import Ecto.Query, only: [from: 2]

  alias Ecto.Changeset
  alias Mixdown.Category
  alias Mixdown.CoverPhoto
  alias Mixdown.Post
  alias Mixdown.Repo
  alias Mixdown.Tag
  alias Mixdown.Thumbnail

  def cover_photo_url(changeset) do
    CoverPhoto.url({Changeset.get_field(changeset, :cover_photo), Changeset.apply_changes(changeset)})
  end

  def thumbnail_url(changeset) do
    Thumbnail.url({Changeset.get_field(changeset, :thumbnail), Changeset.apply_changes(changeset)})
  end

  def all_categories() do
    Repo.all(from c in Category, select: {c.name, c.id}, order_by: c.name)
  end

  def all_tags() do
    Repo.all(from t in Tag, select: {t.name, t.id}, order_by: t.name)
  end

  def selected_tags(changeset) do
    Enum.map(changeset.data.tags, &(&1.id))
  end

end
