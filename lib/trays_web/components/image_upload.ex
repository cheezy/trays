defmodule TraysWeb.ImageUpload do
  use TraysWeb, :html

  @moduledoc false

  use Phoenix.Component
  use Gettext, backend: TraysWeb.Gettext

  attr :image, Phoenix.LiveView.UploadConfig, required: true
  slot :label, required: true
  slot :current_image, required: true
  slot :hint

  def image_upload(assigns) do
    ~H"""
    <div id="image-upload">
      <label for={@image.ref} class="label">
        {render_slot(@label)}
      </label>
      <div class="image-and-upload">
        <div class="current-image">
          {render_slot(@current_image)}
        </div>
        <div class="drop" phx-drop-target={@image.ref}>
          <div>
            <img src="/images/upload.svg" width="45" />
            <div>
              <label for={@image.ref}>
                <span>{gettext("Upload an image")}</span>
                <.live_file_input upload={@image} class="sr-only" />
              </label>
              <span>{gettext("or drag and drop here.")}</span>
            </div>
            <p>
              {render_slot(@hint)}
            </p>
          </div>
        </div>
      </div>

      <.error :for={err <- upload_errors(@image)}>
        {error_to_string(err)}
      </.error>

      <div :for={entry <- @image.entries} class="entry">
        <.live_img_preview entry={entry} />
        <div class="progress">
          <div class="value">
            {entry.progress}%
          </div>
          <div class="bar">
            <span style={"width: #{entry.progress}%"}></span>
          </div>
          <.error :for={err <- upload_errors(@image, entry)}>
            {error_to_string(err)}
          </.error>
        </div>
        <a phx-click="cancel-logo" phx-value-ref={entry.ref}>&times;</a>
      </div>
    </div>
    """
  end

  defp error_to_string(:too_large),
    do: "File too large."

  defp error_to_string(:too_many_files),
    do: "Too many files."

  defp error_to_string(:not_accepted),
    do: "That's not an acceptable file type."
end
