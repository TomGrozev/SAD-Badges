defmodule Badges.Tests.Test do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tests" do
    field :name, :string
    field :planned_date, :utc_datetime

    belongs_to :teacher, Badges.Teachers.Teacher
    has_many :topics, Badges.Tests.Topic
    many_to_many :students, Badges.Students.Student, join_through: Badges.Students.TestsCompleted

    timestamps()
  end

  @doc false
  def changeset(test, attrs) do
    test
    |> cast(attrs, [:name, :planned_date])
    |> validate_required([:name])
  end
end
