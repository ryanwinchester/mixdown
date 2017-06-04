defmodule Mixdown.Repo.Migrations.CreateSeries do
  use Ecto.Migration

  def change do
    create table(:series) do
      add :name, :string
      add :slug, :string
      add :description, :string

      timestamps()
    end

    alter table(:posts) do
      add :series_id, references(:series, on_delete: :nothing)
      add :series_priority, :integer
    end

  end
end
