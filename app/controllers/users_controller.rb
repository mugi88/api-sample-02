class UsersController < ApplicationController
    
    def index
        query = User.all 
        query = query.page(params[:page]).per(params[:limit]).order(updated_at: :desc)
        if params[:query].present?
            query = query.where("name like '%" + params[:query] + "%'").where("bio like '%" + params[:query] + "%'").uniq
        end
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
			query,
			serializer: UserSerializer,
		)
		render json: serializer.as_json
    end

    def update
        @user.update!(user_params)
        serializer = UserSerializer.new(@user)
        render json: serializer.as_json
    end

    def destroy
        @user.destroy!
        render json: {'message': '正常にUserが削除されました！'}
    end

    def show
        serializer = UserSerializer.new(@user)
        render json: serializer.as_json
    end

    def timeline
        query = @user.posts
        query = query.page(params[:page]).per(params[:limit]).order(updated_at: :desc)
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
			query,
			serializer: PostSerializer,
		)
		render json: serializer.as_json
    end

    def user_params
        params.require(:user_params).permit(
            :name,
            :bio
        )
    end

    def set_user
        @user = User.where(id: params[:id]).first
    end

    def check_auth_update
        if @user.id != current_user.id 
            raise ActionController::BadRequest and return
        end
    end
end