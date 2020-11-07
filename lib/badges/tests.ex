defmodule Badges.Tests do
  @moduledoc """
  The Tests context.
  """

  import Ecto.Query, warn: false
  alias Badges.Repo

  alias Badges.Tests.Test

  @doc """
  Returns the list of tests.

  ## Examples

      iex> list_tests()
      [%Test{}, ...]

  """
  def list_tests do
    Repo.all(Test)
  end

  @doc """
  Gets a single test.

  Raises `Ecto.NoResultsError` if the Test does not exist.

  ## Examples

      iex> get_test!(123)
      %Test{}

      iex> get_test!(456)
      ** (Ecto.NoResultsError)

  """
  def get_test!(id), do: Repo.get!(Test, id)

  @doc """
  Creates a test.

  ## Examples

      iex> create_test(%{field: value})
      {:ok, %Test{}}

      iex> create_test(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_test(attrs \\ %{}) do
    %Test{}
    |> Test.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a test.

  ## Examples

      iex> update_test(test, %{field: new_value})
      {:ok, %Test{}}

      iex> update_test(test, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_test(%Test{} = test, attrs) do
    test
    |> Test.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a test.

  ## Examples

      iex> delete_test(test)
      {:ok, %Test{}}

      iex> delete_test(test)
      {:error, %Ecto.Changeset{}}

  """
  def delete_test(%Test{} = test) do
    Repo.delete(test)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking test changes.

  ## Examples

      iex> change_test(test)
      %Ecto.Changeset{data: %Test{}}

  """
  def change_test(%Test{} = test, attrs \\ %{}) do
    Test.changeset(test, attrs)
  end

  alias Badges.Tests.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics(%Test{})
      [%Topic{}, ...]

  """
  def list_topics(%Test{} = test) do
    Repo.all(
      from topic in Topic,
        where: topic.test_id == ^test.id
    )
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%Test{}, %{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%Test{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(%Test{} = test, attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Ecto.Changeset.put_change(:test, test)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{data: %Topic{}}

  """
  def change_topic(%Topic{} = topic, attrs \\ %{}) do
    Topic.changeset(topic, attrs)
  end

  alias Badges.Tests.Part

  @doc """
  Returns the list of parts.

  ## Examples

      iex> list_parts(%Topic{})
      [%Part{}, ...]

  """
  def list_parts(%Topic{} = topic) do
    Repo.all(
      from part in Part,
        where: part.topic_id == ^topic.id
    )
  end

  @doc """
  Gets a single part.

  Raises `Ecto.NoResultsError` if the Part does not exist.

  ## Examples

      iex> get_part!(123)
      %Part{}

      iex> get_part!(456)
      ** (Ecto.NoResultsError)

  """
  def get_part!(id), do: Repo.get!(Part, id)

  @doc """
  Creates a part.

  ## Examples

      iex> create_part(%Topic{}, %{field: value})
      {:ok, %Part{}}

      iex> create_part(%Topic{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_part(%Topic{} = topic, attrs \\ %{}) do
    %Part{}
    |> Part.changeset(attrs)
    |> Ecto.Changeset.put_change(:topic, topic)
    |> Repo.insert()
  end

  @doc """
  Updates a part.

  ## Examples

      iex> update_part(part, %{field: new_value})
      {:ok, %Part{}}

      iex> update_part(part, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_part(%Part{} = part, attrs) do
    part
    |> Part.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a part.

  ## Examples

      iex> delete_part(part)
      {:ok, %Part{}}

      iex> delete_part(part)
      {:error, %Ecto.Changeset{}}

  """
  def delete_part(%Part{} = part) do
    Repo.delete(part)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking part changes.

  ## Examples

      iex> change_part(part)
      %Ecto.Changeset{data: %Part{}}

  """
  def change_part(%Part{} = part, attrs \\ %{}) do
    Part.changeset(part, attrs)
  end

  @doc """
  Searches for tests, topics or parts
  """
  def search_all(query) do
    # Could be done better but move fast and break things sooooooooooo :/
    tests_query =
      from t in Test, where: ilike(t.name, ^"%#{query}%"), select: {t.id, t.name, "test"}

    topics_query =
      from t in Topic,
        where: ilike(t.name, ^"%#{query}%"),
        select: {t.id, t.name, "topic"},
        union: ^tests_query

    parts_query =
      from p in Part,
        where: ilike(p.name, ^"%#{query}%"),
        select: {p.id, p.name, "part"},
        union: ^topics_query

    Repo.all(parts_query)
  end

  alias Badges.Activities.Activity
  alias Badges.Students.{TestsCompleted, TopicsCompleted, PartsCompleted}

  @doc """
  Marks a test, topic or part as complete
  """
  def mark_complete(%Activity{id: a_id}, s_id, "test", t_id)
      when not is_nil(a_id) and not is_nil(s_id) do
    TestsCompleted.changeset(%TestsCompleted{}, %{
      activity_id: a_id,
      test_id: t_id,
      student_id: s_id
    })
    |> Repo.insert()
  end

  def mark_complete(%Activity{id: a_id}, s_id, "topic", t_id)
      when not is_nil(a_id) and not is_nil(s_id) do
    TopicsCompleted.changeset(%TopicsCompleted{}, %{
      activity_id: a_id,
      topic_id: t_id,
      student_id: s_id
    })
    |> Repo.insert()
  end

  def mark_complete(%Activity{id: a_id}, s_id, "part", t_id)
      when not is_nil(a_id) and not is_nil(s_id) do
    PartsCompleted.changeset(%PartsCompleted{}, %{
      activity_id: a_id,
      part_id: t_id,
      student_id: s_id
    })
    |> Repo.insert()
  end

  @doc """
  Gets a completed test, topic or part
  """
  def get_completed!(type, id) when type in [:test, :topic, :part] do
    case type do
      :test -> TestsCompleted
      :topic -> TopicsCompleted
      :part -> PartsCompleted
    end
    |> Repo.get!(id)
  end

  @doc """
  Deletes a completed test, topic or part with id
  """
  def delete_completed(%mod{} = completed)
      when mod in [TestsCompleted, TopicsCompleted, PartsCompleted] do
    Repo.delete(completed)
  end
end
