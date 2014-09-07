class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]

  def index
    params[:order_by] ||= :created_at
    params[:order] ||= :desc
    params[:page] ||= 1
    params[:per_page] ||= 30

    ideas =
      if params[:q].present?
        Idea.fuzzy_search({title: params[:q], description: params[:q], tags: params[:q], materials: params[:q]}, false)
      else
        Idea.all
      end
    @ideas = ideas.page(params[:page]).
      per(params[:per_page]).
      order(params[:order_by] => params[:order].to_sym).
      where({user: params[:user]}.select { |_, v| v.present? })
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user

    respond_to do |format|
      if @idea.save
        format.html { redirect_to ideas_path, notice: 'Idea was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @idea.user == current_user && @idea.update(idea_params)
        format.html { redirect_to ideas_path, notice: 'Idea was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @idea.user == current_user
      @idea.destroy
    end
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
    end
  end

  private
    def set_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:title, :description, :from, :tags, :materials, :min_partners, :grade)
    end
end
