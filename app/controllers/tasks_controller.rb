class TasksController < ApplicationController

  def index
    @tasks = helpers.get_resources(:tasks)
  end

  def show
    @task = helpers.get_resource(:tasks, params)
  end
end
