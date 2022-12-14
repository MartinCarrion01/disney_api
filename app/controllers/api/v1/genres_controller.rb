class Api::V1::GenresController < ApplicationController

    before_action :set_genre, only: %i[show update destroy set_image]
    
    def index
        genres = Genre.all
        render(json: {genres: genres}, status: :ok)
    end

    def show
        render(json: {genre: @genre}, status: :ok)
    end

    def create
        genre = Genre.new(genre_params)
        if genre.save
            render(json: {genre: genre}, status: :created)
        else
            render(json: {message: genre.errors}, status: :unprocessable_entity)
        end
    end

    def update
        if @genre.update(genre_params)
            render(json: {genre: @genre}, status: :ok)
        else
            render(json: {message: {@genre.errors}}, status: :unprocessable_entity)
        end
    end

    def destroy
        if @genre.destroy
            render(status: :no_content)
        else
            render(json: {message: @genre.errors}, status: :bad_request)
        end
    end

    def set_image
        @genre.image.purge if @genre.image.attached?
        @genre.image.attach(params[:image])
        if @genre.save
            render(json: { message: "Imagen de personaje establecida correctamente" }, status: :created)
        else
            render(json: { message: @genre.errors }, status: :unprocessable_entity)
        end
    end

    private

    def genre_params
        params.require(:genre).permit(:name)
    end

    def set_genre
        @genre = Genre.find_by(id: params[:id])
        if @genre.nil?
            render(json: {message: "El genero solicitado no existe"}, status: :not_found)
            false
        end
    end
end
