defmodule <%= inspect context.web_module %>.ModalComponent do
  use <%= inspect context.web_module %>, :live_component

  @impl true
  def render(assigns) do
     ~L"""
     <div id="<%%= @id %>" class="fixed bottom-0 w-full h-full inset-x-0 p-4 z-40 sm:inset-0 sm:flex sm:items-center sm:justify-center"
       phx-capture-click="close"
       phx-window-keydown="close"
       phx-key="escape"
       phx-target="#<%%= @id %>"
       phx-page-loading>

       <div class="fixed inset-0 transition-opacity">
         <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
       </div>

       <div class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-xl sm:w-full" role="dialog" aria-modal="true" aria-labelledby="modal-headline">
         <%%= live_component @socket, @component, @opts %>
       </div>
     </div>
     """
 end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
