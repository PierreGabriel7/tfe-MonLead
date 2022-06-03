class UserAvatarController < ApplicationController
  before_action :redirect_if_logged_off

  def upload
    uploaded_io = params[:avatar]
    extension = File.extname(uploaded_io.original_filename)

    # Check if uploaded file is a png or jpg
    if extension != ".png" && extension != ".jpg"
      flash[:error] = t("controller.user_avatar.not_img").capitalize + "."
      redirect_to controller: "users", action: "show"
    else
      # Delete user profile file if there is one already
      if @profile_picture_url.include? "@"
        File.delete(File.join(Rails.public_path, @profile_picture_url))
      end

      # Moving the file to some safe place; as tmp files will be flushed timely
      File.open(Rails.root.join("public", "uploads", @current_user.email + extension), "wb") do |file|
        file.write(uploaded_io.read)
        flash[:success] = t("controller.user_avatar.updated").capitalize + "."
        redirect_to controller: "users", action: "show"
      end
    end
  end
end
