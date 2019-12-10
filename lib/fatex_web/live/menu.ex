defmodule FatexWeb.MenuLive do
  use FatexWeb, :live
  require Logger

  def render(assigns) do
    FatexWeb.MenuView.render("index.html", assigns)
  end

  def mount(%{step_id: nil, model_id: model_id, csrf_token: token} = _session, socket) do
    uploads = get_uploads_names(model_id)
    {:ok, assign(socket, templates: [], model_id: model_id, token: token, uploads: uploads)}
  end

  def mount(%{step_id: id, model_id: model_id, csrf_token: token} = _session, socket) do
    step = LatexConfigs.get_step(id)
    templates = LatexConfigs.list_template_sections_from_step(step)
    uploads = get_uploads_names(model_id)

    {:ok,
     assign(socket,
       templates: templates,
       step_id: id,
       model_id: model_id,
       token: token,
       uploads: uploads
     )}
  end

  defp get_uploads_names(model_id) do
    {:ok, files} = File.ls("maker/#{model_id}/figures/")
    files
  end

  ##########
  # EVENTS #
  ##########

  def handle_event("to_add", %{"template_id" => template_id}, socket) do
    PubSub.broad_to_add(socket.assigns.step_id, template_id)
    {:noreply, socket}
  end

  def handle_event("remove_upload", %{"upload_name" => name}, socket) do
    File.rm("maker/#{socket.assigns.model_id}/figures/#{name}")
    {:noreply, assign(socket, :uploads, List.delete(socket.assigns.uploads, name))}
  end
end
