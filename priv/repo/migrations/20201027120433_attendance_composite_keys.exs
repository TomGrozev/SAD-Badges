defmodule Badges.Repo.Migrations.AttendanceCompositeKeys do
  use Ecto.Migration

  def change do
    create unique_index(:activity_attendance, [:activity_id, :student_id])
  end
end
