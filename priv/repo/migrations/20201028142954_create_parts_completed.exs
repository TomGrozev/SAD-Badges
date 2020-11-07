defmodule Badges.Repo.Migrations.CreatePartsCompleted do
  use Ecto.Migration

  def change do
    create table(:parts_completed) do
      add :datetime, :utc_datetime
      add :student_id, references(:students, on_delete: :delete_all)
      add :part_id, references(:parts, on_delete: :delete_all)

      timestamps()
    end
  end
end
