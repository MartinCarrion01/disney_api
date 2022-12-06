class Api::V1::TitlesController < ApplicationController
    before_action :set_title, only: %i[add_character]
    
    def create
        title = Title.new(title_params)
        if title.save
            render(json: {title: title}, status: :created)
        else
            render(json: {message: title.errors}, status: :unprocessable_entity)
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
