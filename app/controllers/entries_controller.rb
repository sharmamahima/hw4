class EntriesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @entry = Entry.new
    # Optionally, preload the place_id if passed via query parameters
    @entry.place_id = params[:place_id] if params[:place_id].present?
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = session[:user_id] # Associate entry with the logged-in user

    if @entry.save
      redirect_to place_path(@entry.place_id), notice: 'Entry was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :place_id, :image)
  end

  def require_login
    unless session[:user_id]
      flash[:alert] = "You must be logged in to access this section"
      redirect_to login_url # Use the path helper for the login route
    end
  end
end