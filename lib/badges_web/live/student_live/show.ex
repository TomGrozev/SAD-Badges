defmodule BadgesWeb.StudentLive.Show do
  use BadgesWeb, :live_view

  alias Badges.Students

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    student =
      Students.get_student!(id)
      |> Students.load_completed()

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:student, student)}
  end

  defp page_title(:show), do: "Show Student"
  defp page_title(:edit), do: "Edit Student"
end
