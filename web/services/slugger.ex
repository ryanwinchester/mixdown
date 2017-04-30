defmodule Mixdown.Slugger do
  def slugify(nil), do: nil
  def slugify(str) do
    str
    |> String.downcase()
    |> Slugger.slugify()
  end
end
