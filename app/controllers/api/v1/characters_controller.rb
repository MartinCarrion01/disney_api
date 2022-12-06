class Api::V1::CharactersController < ApplicationController
    
    before_action :set_character, only: %i[set_image update destroy show]

    def index
        @characters = Character.
    end

    def show
        render(json: {character: @character.get_detail}, status: :ok)
    end

    def create
        @character = Character.new(character_params)
        if @character.save
            render(json: {character: @character}, status: :created)
        else
            render(json: {message: @character.errors}, status: :unprocessable_entity)
        end
    end

    def update
        if @character.update(character_params)
            render(json: {character: @character}, status: :ok)
        else
            render(json: {message: @character.errors}, status: :unprocessable_entity)
        end
    end

    def destroy
        if @character.destroy
            render(status: :no_content)
        else
            render(json: {message: @character.errors}, status: :bad_request)
        end
    end

    def list
        @characters = Character.list
        render(json: {characters: @characters}, status: :ok)
    end

    def set_image
        @character.image.purge if @character.image.attached?
        @character.image.attach(params[:image])
        if @character.save
            render(json: { message: "Imagen de personaje establecida correctamente" }, status: :created)
        else
            render(json: { message: @character.errors }, status: :unprocessable_entity)
        end
    end

    private
    def character_params
        params.require(:character).permit(:name, :weight, :age, :description)
    end

    def set_character
        @character = Character.find_by(id: params[:id])
        if @character.nil? 
            render(json: {message: "El personaje solicitado no existe"}, status: :not_found)
            false
        end
    end
end
