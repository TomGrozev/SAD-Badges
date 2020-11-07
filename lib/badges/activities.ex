defmodule Badges.Activities do
  @moduledoc """
  The Activities context.
  """

  import Ecto.Query, warn: false
  alias Badges.Repo

  alias Badges.Activities.Activity

  @doc """
  Returns the list of activities.

  ## Examples

      iex> list_activities()
      [%Activity{}, ...]

  """
  def list_activities do
    Repo.all(Activity)
  end

  @doc """
  Gets a single activity.

  Raises `Ecto.NoResultsError` if the Activity does not exist.

  ## Examples

      iex> get_activity!(123)
      %Activity{}

      iex> get_activity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_activity!(id) do
    Repo.get!(Activity, id)
  end

  @doc """
  Creates a activity.

  ## Examples

      iex> create_activity(%{field: value})
      {:ok, %Activity{}}

      iex> create_activity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_activity(attrs \\ %{}) do
    %Activity{}
    |> Activity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a activity.

  ## Examples

      iex> update_activity(activity, %{field: new_value})
      {:ok, %Activity{}}

      iex> update_activity(activity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_activity(%Activity{} = activity, attrs) do
    activity
    |> Activity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a activity.

  ## Examples

      iex> delete_activity(activity)
      {:ok, %Activity{}}

      iex> delete_activity(activity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_activity(%Activity{} = activity) do
    Repo.delete(activity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking activity changes.

  ## Examples

      iex> change_activity(activity)
      %Ecto.Changeset{data: %Activity{}}

  """
  def change_activity(%Activity{} = activity, attrs \\ %{}) do
    Activity.changeset(activity, attrs)
  end

  alias Badges.Activities.Attendance

  def get_attendances(%Activity{} = activity) do
    query = from a in Attendance,
            where: a.activity_id == ^activity.id,
            preload: [:student],
            group_by: a.id

    Repo.all(query)
  end

  @doc """

  """
  def upsert_attendance(%Attendance{} = attendance, attrs) do
    attendance
    |> Attendance.changeset(attrs)
    |> maybe_clear_reason()
    |> Repo.insert_or_update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking attendance changes.

  ## Examples

      iex> change_attendance(attendance)
      %Ecto.Changeset{data: %Attendance{}}

  """
  def change_attendance(%Attendance{} = attendance, attrs \\ %{}) do
    Attendance.changeset(attendance, attrs)
  end

  defp maybe_clear_reason(changeset) do
    if Ecto.Changeset.get_field(changeset, :status) == "present" do
      Ecto.Changeset.put_change(changeset, :reason, nil)
    else
      changeset
    end
  end

  alias Badges.Students.{TestsCompleted, TopicsCompleted, PartsCompleted}

  @doc """
  Lists all completed tests, topics and parts at an activity
  """
  def list_completed(%Activity{} = activity) do
    tests =
      Repo.all(
        from t in TestsCompleted,
          where: t.activity_id == ^activity.id,
          join: test in assoc(t, :test),
          join: student in assoc(t, :student),
          preload: [test: test, student: student],
          select: {t, :test}
      )

    topics =
      Repo.all(
        from t in TopicsCompleted,
          where: t.activity_id == ^activity.id,
          join: topic in assoc(t, :topic),
          join: student in assoc(t, :student),
          preload: [topic: topic, student: student],
          select: {t, :topic}
      )

    parts =
      Repo.all(
        from p in PartsCompleted,
          where: p.activity_id == ^activity.id,
          join: part in assoc(p, :part),
          join: student in assoc(p, :student),
          preload: [part: part, student: student],
          select: {p, :part}
      )

    Enum.concat([tests, topics, parts])
  end
end
