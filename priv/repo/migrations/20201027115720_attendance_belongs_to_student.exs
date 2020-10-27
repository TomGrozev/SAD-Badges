defmodule Badges.Repo.Migrations.AttendanceBelongsToStudent do
  use Ecto.Migration

  def change do
    alter table(:activity_attendance) do
      add :student_id, references(:students)
    end
  end
end
