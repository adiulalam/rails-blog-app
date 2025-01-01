class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create update destroy my_posts ]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.completed.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    # If the user is not signed in, ensure the post is not a draft
    if current_user.nil? && @post.is_draft?
      redirect_to posts_path, alert: "You can't view this draft post." and return
    end

    # If the user is signed in, check if the post belongs to them
    if current_user.present? && @post.is_draft? && @post.user != current_user
      redirect_to posts_path, alert: "You are not authorized to view this post." and return
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def my_posts
    @show_drafts_only = params[:drafts_only] == "true"
    @posts = current_user.posts.order(created_at: :desc)
    @posts = @posts.draft if @show_drafts_only
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :is_draft)
  end

  def authorize_user!
    redirect_to posts_path, alert: "You are not authorized to perform this action." unless @post.user == current_user
  end
end
