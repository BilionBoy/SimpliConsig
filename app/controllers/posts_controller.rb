# frozen_string_literal: true
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Post.ransack(params[:q])
    @pagy, @posts = pagy(@q.result)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_url, notice: t('messages.deleted_successfully')
    else
      redirect_to posts_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    return redirect_to posts_path, alert: t('messages.not_found') unless @post
  end

  def post_params
    permitted_attributes = Post.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:post).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to posts_path, alert: t('messages.not_found')
  end
end
