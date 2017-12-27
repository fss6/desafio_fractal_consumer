class ProjectsController < ApplicationController
  before_action :set_categories, only: [:new, :edit, :create, :update]
  before_action :set_project, only: [:show, :edit]

  def index
# abort params.inspect
    @projects = helpers.get_resources(:projects, params[:term])
  end

  def new
  end

  def create
    begin
      helpers.post_resource(:projects, params.merge(user_id: get_current_user_id))
      redirect_to(projects_path, flash: helpers.flash_success(:created))
    rescue Exception => e
      helpers.flash_errors(e.response)
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    begin
      helpers.put_resource(:projects, params.merge(user_id: get_current_user_id))
      redirect_to(projects_path, flash: helpers.flash_success(:updated))
    rescue Exception => e
      helpers.flash_errors(e.response)
      render :edit
    end
  end

  def destroy
    begin
      helpers.delete_resource(:projects, params)
      redirect_to(projects_path, flash: helpers.flash_success(:deleted))
    rescue Exception => e
      helpers.flash_errors(e.response)
      redirect_to(projects_path, flash: helpers.flash_success(:updated))
    end
  end

  private
  def set_project
    @project = helpers.get_resource(:projects, params)
  end

  def set_categories
    result = helpers.get_resources(:categories)

    @categories = helpers.get_collection(result).collect{ |category|
      [category[:attributes][:name], category[:id]]
    }
  end
end
