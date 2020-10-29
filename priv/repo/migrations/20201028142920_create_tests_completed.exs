defmodule Badges.Repo.Migrations.CreateTestsCompleted do
  use Ecto.Migration

  def change do
    create table(:tests_completed) do
      add :datetime, :utc_datetime
      add :student_id, references(:students)
      add :test_id, references(:tests)

      timestamps()
    end

  end
end
