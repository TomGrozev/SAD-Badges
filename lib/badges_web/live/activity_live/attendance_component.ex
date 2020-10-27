defmodule BadgesWeb.ActivityLive.AttendanceComponent do
  use BadgesWeb, :live_component

  alias Badges.Activities

  @impl true
  def update(%{attendance: attendance} = assigns, socket) do
    changeset = Activities.change_attendance(attendance)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("save", params, socket) do
    case Map.fetch(params, "attendance_" <> to_string(socket.assigns.id)) do
      {:ok, attendance_params} ->
        changeset =
          socket.assigns.attendance
          |> Activities.change_attendance(attendance_params)
          |> Map.put(:action, :validate)

        if changeset.valid? do
          update_attendance(socket, attendance_params, changeset)
        else
          {:noreply, assign(socket, :changeset, changeset)}
        end

      :error ->
        {:noreply, socket}
    end
  end

  #  defp has_attendance?(params) do
  #    Map.keys(params)
  #    |> Enum.any?(& String.starts_with?(&1, "attendance_"))
  #  end

  defp update_attendance(socket, attrs, changeset) do
    case Activities.upsert_attendance(socket.assigns.attendance, attrs) do
      {:ok, _attendance} ->
        {:noreply,
         socket
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
