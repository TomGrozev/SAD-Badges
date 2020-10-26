defmodule BadgesWeb.TestLive.FormComponent do
  use BadgesWeb, :live_component

  alias Badges.Tests

  @impl true
  def update(%{test: test} = assigns, socket) do
    changeset = Tests.change_test(test)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"test" => test_params}, socket) do
    changeset =
      socket.assigns.test
      |> Tests.change_test(test_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"test" => test_params}, socket) do
    save_test(socket, socket.assigns.action, test_params)
  end

  defp save_test(socket, :edit, test_params) do
    case Tests.update_test(socket.assigns.test, test_params) do
      {:ok, _test} ->
        {:noreply,
         socket
         |> put_flash(:info, "Test updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_test(socket, :new, test_params) do
    case Tests.create_test(test_params) do
      {:ok, _test} ->
        {:noreply,
         socket
         |> put_flash(:info, "Test created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
