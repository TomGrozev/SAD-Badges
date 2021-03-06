defmodule Badges.Teachers.Teacher do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teachers" do
    field :first_name, :string
    field :last_name, :string

    has_many :tests, Badges.Tests.Test

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end
