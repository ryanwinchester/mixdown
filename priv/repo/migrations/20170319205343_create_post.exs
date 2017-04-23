defmodule Mixdown.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :subtitle, :string
      add :slug, :string
      add :content, :text
      add :cover_photo, :string, null: true
      add :thumbnail, :string, null: true
      add :is_published, :boolean, default: false, null: false
      add :published_at, :naive_datetime

      add :category_id, references(:categories, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:posts, [:slug])
    create index(:posts, [:user_id])

  end
end
