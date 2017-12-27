class CategoriesController < ApplicationController

  def index
    @categories = helpers.get_resources(:categories)
  end
end
