defmodule Badges.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :dob, :date
    field :first_name, :string
    field :last_name, :string

    has_many :attendances, Badges.Students.Student
    belongs_to :group, Badges.Students.Group

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name, :dob, :group_id])
    |> validate_required([:first_name, :last_name, :dob])
    |> assoc_constraint(:group)
  end
end
