defmodule BadgesWeb.Partials.SearchComponent do
  use BadgesWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok,
      socket
      |> assign(:query, "")}
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
      socket
      |> assign(assigns)}
  end

  def handle_event("search", %{"q" => query}, socket) do
    send_update(BadgesWeb.ActivityLive.FormCompleteComponent, [
      id: :new,
      query: {socket.assigns.id, query}
    ])

    {:noreply, socket}
  end
end
