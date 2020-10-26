defmodule BadgesWeb.TeacherLive.FormComponent do
  use BadgesWeb, :live_component

  alias Badges.Teachers

  @impl true
  def update(%{teacher: teacher} = assigns, socket) do
    changeset = Teachers.change_teacher(teacher)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"teacher" => teacher_params}, socket) do
    changeset =
      socket.assigns.teacher
      |> Teachers.change_teacher(teacher_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"teacher" => teacher_params}, socket) do
    save_teacher(socket, socket.assigns.action, teacher_params)
  end

  defp save_teacher(socket, :edit, teacher_params) do
    case Teachers.update_teacher(socket.assigns.teacher, teacher_params) do
      {:ok, _teacher} ->
        {:noreply,
         socket
         |> put_flash(:info, "Teacher updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_teacher(socket, :new, teacher_params) do
    case Teachers.create_teacher(teacher_params) do
      {:ok, _teacher} ->
        {:noreply,
         socket
         |> put_flash(:info, "Teacher created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
