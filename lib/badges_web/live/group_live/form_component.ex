defmodule BadgesWeb.GroupLive.FormComponent do
  use BadgesWeb, :live_component

  alias Badges.Students

  @impl true
  def update(%{group: group} = assigns, socket) do
    changeset = Students.change_group(group)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"group" => group_params}, socket) do
    changeset =
      socket.assigns.group
      |> Students.change_group(group_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"group" => group_params}, socket) do
    save_group(socket, socket.assigns.action, group_params)
  end

  defp save_group(socket, :edit, group_params) do
    case Students.update_group(socket.assigns.group, group_params) do
      {:ok, _group} ->
        {:noreply,
         socket
         |> put_flash(:info, "Group updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_group(socket, :new, group_params) do
    case Students.create_group(group_params) do
      {:ok, _group} ->
        {:noreply,
         socket
         |> put_flash(:info, "Group created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
