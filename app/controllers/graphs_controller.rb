class GraphsController < ApplicationController
  def main
    @data = []
    genres = Movie.uniq.pluck(:genre)
    @input = genres
    selections = params[:selections]
    if !selections.nil?
      @test = true
      selections.each do |g|
        movies = Movie.where(genre:g)
        value = []
        movies.each do |m|
          value << {"x" => m.audience, 'y' => m.rotten, 'size' => m.worldwidegross, 'shape' => 'circle', 'name' => m.name}
        end
        @data << {'key' => g, 'values' => value}
      end
    end

  end
end
