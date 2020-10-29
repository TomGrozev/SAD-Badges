defmodule Badges.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :datetime, :utc_datetime
    field :name, :string

    has_many :attendances, Badges.Activities.Attendance
    has_many :tests, Badges.Tests.Test
    has_many :topics, Badges.Tests.Topic
    has_many :parts, Badges.Tests.Part

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:datetime, :name])
    |> validate_required([:datetime, :name])
  end
end
