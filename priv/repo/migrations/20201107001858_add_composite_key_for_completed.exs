defmodule Badges.Repo.Migrations.AddCompositeKeyForCompleted do
  use Ecto.Migration

  def change do
    create unique_index(:tests_completed, [:test_id, :student_id])
    create unique_index(:topics_completed, [:topic_id, :student_id])
    create unique_index(:parts_completed, [:part_id, :student_id])
  end
end
