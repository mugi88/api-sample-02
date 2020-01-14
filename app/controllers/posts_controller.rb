class PostsController < ApplicationController

    def create
        post = Post.new(post_params)
        post.user_id = current_user.id
        post.save!
        serializer = PostSerializer.new(post)
        render json: serializer.as_json
    end

    def index
        query = Post.all 
        query = query.page(params[:page]).per(params[:limit]).order(updated_at: :desc)
        if params[:query].present?
            query = query.where("text like '%" + params[:query] + "%'")
        end
        serializer = ActiveModel::Serializer::CollectionSerializer.new( query, serializer: PostSerializer, )
		render json: serializer.as_json
    end

    def show
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: @post }
    end

    def destroy
        @post.destroy
        render json: { status: 'SUCCESS', message: 'Post削除しました！', data: @post}
    end


    def update
        if @post.update(post_params)
            render json: { status: 'SUCCESS', message: 'Updated done!', data: @post }
        else
            render json: { status: 'SUCCESS', message: 'Not update...', data: @post.errors }
        end
    end

    def set_post
        @post = Post.where(params[:id]).first
    end

    def post_params
        params.require(:post).permit(:text)
    end
end
