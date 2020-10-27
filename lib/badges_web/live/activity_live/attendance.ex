defmodule BadgesWeb.ActivityLive.Attendance do
  use BadgesWeb, :live_view

  alias Badges.Activities
  alias Badges.Activities.Attendance
  alias Badges.Students

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    activity = Activities.get_activity!(id)

    {:noreply,
     socket
     |> assign(:attendances, get_attendances(activity))
     |> assign(:activity, activity)}
  end

  defp get_attendances(activity) do
    activity
    |> Activities.load_attendances()
    |> Map.get(:attendances)
    |> case do
      [] -> create_attendances(activity)
      %Ecto.Association.NotLoaded{} -> create_attendances(activity)
      attendances -> attendances
    end
  end

  defp create_attendances(activity) do
    Students.list_students()
    |> Enum.map(fn student ->
      %Attendance{}
      |> Map.put(:student, student)
      |> Map.put(:activity, activity)
    end)
  end
end
