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

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    payload = {socket.assigns.id, query}
    case socket.assigns.target do
      :self ->
        send(self(), {:query, payload})

      {target, target_id} ->
        send_update(target,
          id: target_id,
          query: payload
        )

      target ->
        send_update(target,
          id: :new,
          query: payload
        )
    end

    {:noreply, socket}
  end
end
