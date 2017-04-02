defmodule Mixdown.Admin.PostView do
  use Mixdown.Web, :view

  alias Ecto.Changeset
  alias Mixdown.CoverPhoto
  alias Mixdown.Thumbnail

  def cover_photo_url(changeset) do
    CoverPhoto.url({Changeset.get_field(changeset, :cover_photo), Changeset.apply_changes(changeset)})
  end

  def thumbnail_url(changeset) do
    Thumbnail.url({Changeset.get_field(changeset, :thumbnail), Changeset.apply_changes(changeset)})
  end

end
