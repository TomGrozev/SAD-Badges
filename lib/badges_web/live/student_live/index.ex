defmodule BadgesWeb.StudentLive.Index do
  use BadgesWeb, :live_view

  alias Badges.Students
  alias Badges.Students.Student

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :students, list_students())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Student")
    |> assign(:student, Students.get_student!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Student")
    |> assign(:student, %Student{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Students")
    |> assign(:student, nil)
  end

  @impl true
  def handle_info({:query, {:students, query}}, socket) do
    students = if query == "", do: list_students(), else: Students.search_students(query)

    {:noreply, assign(socket, :students, students)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    student = Students.get_student!(id)
    {:ok, _} = Students.delete_student(student)

    {:noreply, assign(socket, :students, list_students())}
  end

  defp list_students do
    Students.list_students()
  end

  defp get_group_name(%Ecto.Association.NotLoaded{}), do: get_group_name(nil)
  defp get_group_name(nil), do: "None"
  defp get_group_name(group), do: group.name
end
