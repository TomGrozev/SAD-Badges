defmodule Badges.Repo.Migrations.CreatePartsCompleted do
  use Ecto.Migration

  def change do
    create table(:parts_completed) do
      add :datetime, :utc_datetime
      add :student_id, references(:students)
      add :part_id, references(:parts)

      timestamps()
    end

  end
end
