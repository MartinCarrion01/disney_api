class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_request, only: %i[create]

    def create
        user = User.new(create_user_params)
        if user.save
            render(json: { user: user }, status: :created)
        else
            render(json: { message: user.errors }, status: :unprocessable_entity)
        end
    end

    private 

    def create_user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
