defmodule Badges.Activities.Attendance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activity_attendance" do
    field :status, :string, default: "absent"
    field :reason, :string, null: true

    belongs_to :activity, Badges.Activities.Activity
    belongs_to :student, Badges.Students.Student

    timestamps()
  end

  @doc false
  def changeset(attendance, attrs) do
    attendance
    |> cast(attrs, [:status, :reason])
    |> validate_required([:status])
    |> unique_constraint([:activity_id, :student_id])
  end
end
