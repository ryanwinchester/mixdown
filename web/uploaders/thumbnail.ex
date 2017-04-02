defmodule Mixdown.Thumbnail do
  use Arc.Definition

  @acl :public_read

  @versions [:original]

  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  @doc """
  Whitelist file extensions.
  """
  def validate({file, _scope}) do
    extension =
      file.file_name
      |> Path.extname()
      |> String.downcase()
    Enum.member?(@extension_whitelist, extension)
  end

  @doc """
  Define a thumbnail transformation.
  """
  def transform(_, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  @doc """
  Override the persisted filenames.
  """
  def filename(version, {file, _scope}) do
    file.file_name
    |> Path.basename(Path.extname(file.file_name))
    |> (fn file_name -> "thumbnail_#{file_name}" end).()
    |> String.downcase()
  end

  @doc """
  Override the storage directory.
  """
  def storage_dir(_version, {_file, scope}) do
    "/uploads/posts/#{scope.id}"
  end

  @doc """
  Provide a default URL if there hasn't been a file uploaded.
  """
  def default_url(_version, _scope) do
    "/images/post-sample-image.jpg"
  end

  @doc """
  Specify S3 headers.
  """
  def s3_object_headers(_version, {file, _scope}) do
    [content_type: Plug.MIME.path(file.file_name)]
  end

end
