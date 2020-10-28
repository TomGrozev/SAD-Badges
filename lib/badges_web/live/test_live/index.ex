defmodule BadgesWeb.TestLive.Index do
  use BadgesWeb, :live_view

  alias Badges.Tests
  alias Badges.Tests.Test

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :tests, list_tests())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    IO.inspect(params)
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"test_id" => id}) do
    socket
    |> assign(:page_title, "Edit Test")
    |> assign(:test, Tests.get_test!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Test")
    |> assign(:test, %Test{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tests")
    |> assign(:test, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    test = Tests.get_test!(id)
    {:ok, _} = Tests.delete_test(test)

    {:noreply, assign(socket, :tests, list_tests())}
  end

  defp list_tests do
    Tests.list_tests()
  end
end
