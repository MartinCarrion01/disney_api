class Api::V1::AuthController < ApplicationController
    skip_before_action :authenticate_request, only: [:login]

    def login
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            token = jwt_encode(user_id: user.id)
            render(json: {token: token}, status: :ok)
        else
            error = user ? "Contraseña incorrecta" : "El usuario ingresado no existe"
            render(json: {message: error}, status: :unauthorized)
        end
    end

    def change_password
        if @current_user.authenticate(params[:current_password])
            if @current_user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
                render(json: {message: "Contraseña cambiada correctamente"}, status: :ok)
            else
                render(json: {message: @current_user.errors}, status: :unprocessable_entity)
            end
        else
            render(json: {message: "La contraseña actual es incorrecta"}, status: :unauthorized)
        end
    end
end
