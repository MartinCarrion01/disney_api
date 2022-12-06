class Api::V1::TitlesController < ApplicationController
    before_action :set_title, only: %i[show update destroy add_character]
    
    def index
        if params[:order] != "DESC" && params[:order] != "ASC"
            render(json: {message: "Parametro order incorrecto, debe ser ASC o DESC"}, status: :bad_request)
            return
        end
        titles = Title.index(params[:name], params[:genre_id], params[:order])
        render(json: {titles: titles}, status: :ok)
    end

    def show
        render(json: {title: @title.get_detail}, status: :ok)
    end

    def create
        title = Title.new(title_params)
        if title.save
            render(json: {title: title}, status: :created)
        else
            render(json: {message: title.errors}, status: :unprocessable_entity)
        end
    end

    def update
        if @title.update(title_params)
            render(json: {title: @title}, status: :ok)
        else
            render(json: {message: @title.errors}, status: :unprocessable_entity)
        end
    end

    def destroy
        if @title.destroy
            render(status: :not_found)
        else
            render(json: {message: @title.errors}, status: :bad_request)
        end
    end

    def add_character
        @title_character = TitleCharacter.find_or_initialize_by(title_id: @title.id, character_id: params[:character_id])
        if @title_character.persisted?
            render(json: {message: "El personaje ya esta cargado en la película"}, status: :ok)
        elsif @title_character.save
            render(json: {message: "El personaje fue cargado exitosamente en la película"}, status: :ok)
        else
            render(json: {message: @title_character.errors}, status: :unprocessable_entity)
        end
    end

    private
    
    def title_params
        params.require(:title).permit(:name, :score, :genre_id)
    end

    def set_title
        @title = Title.find_by(id: params[:id])
        if @title.nil?
            render(json: {message: "El titulo solicitado no existe"}, status: :not_found)
            false
        end
    end
end
