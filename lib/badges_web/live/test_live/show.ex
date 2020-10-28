defmodule BadgesWeb.TestLive.Show do
  use BadgesWeb, :live_view

  alias Badges.Tests

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"test_id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:test, Tests.get_test!(id))}
  end

  defp page_title(:show), do: "Show Test"
  defp page_title(:edit), do: "Edit Test"
end
