defmodule Badges.Students.PartsCompleted do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parts_completed" do
    belongs_to :student, Badges.Students.Student
    belongs_to :part, Badges.Tests.Part
    belongs_to :activity, Badges.Activities.Activity

    timestamps()
  end

  @doc false
  def changeset(parts_completed, attrs) do
    parts_completed
    |> cast(attrs, [:student_id, :part_id, :activity_id])
    |> validate_required([:student_id, :part_id, :activity_id])
  end
end
