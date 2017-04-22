defmodule Mixdown.Admin.PostView do
  use Mixdown.Web, :view

  import Ecto.Query, only: [from: 2]

  alias Ecto.Changeset
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

  def all_tags() do
    Repo.all(from t in Tag, select: {t.name, t.id})
  end

  def selected_tags(changeset) do
    Enum.map(changeset.data.tags, &(&1.id))
  end

end
