defmodule Badges.Students.TestsCompleted do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tests_completed" do
    belongs_to :student, Badges.Students.Student
    belongs_to :test, Badges.Tests.Test
    belongs_to :activity, Badges.Activities.Activity

    timestamps()
  end

  @doc false
  def changeset(tests_completed, attrs) do
    tests_completed
    |> cast(attrs, [:student_id, :test_id, :activity_id])
    |> validate_required([:student_id, :test_id, :activity_id])
  end
end
