defmodule BadgesWeb.TeacherLive.Index do
  use BadgesWeb, :live_view

  alias Badges.Teachers
  alias Badges.Teachers.Teacher

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :teachers, list_teachers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Teacher")
    |> assign(:teacher, Teachers.get_teacher!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Teacher")
    |> assign(:teacher, %Teacher{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Teachers")
    |> assign(:teacher, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    teacher = Teachers.get_teacher!(id)
    {:ok, _} = Teachers.delete_teacher(teacher)

    {:noreply, assign(socket, :teachers, list_teachers())}
  end

  defp list_teachers do
    Teachers.list_teachers()
  end
end
