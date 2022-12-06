class Api::V1::GenresController < ApplicationController
    
    def create
        @genre = Genre.new(genre_params)
        if @genre.save
            render(json: {genre: @genre}, status: :created)
        else
            render(json: {message: @genre.errors}, status: :unprocessable_entity)
        end
    end

    private

    def genre_params
        params.require(:genre).permit(:name)
    end
end
