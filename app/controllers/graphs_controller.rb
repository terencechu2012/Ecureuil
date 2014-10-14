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
  
  def main2
    x = params[:x]
    movies = Movie.order(profitability: :desc)
    @result = []
    @result2 = []
    if x.to_i == 100
      for i in 0..50
        m = movies[i]
        if !m.nil?
          @result << [m.name, m.profitability]
          @result2 << {'group' => m.name, 'category' => 'budget', 'measure' => m.budget}
          @result2 << {'group' => m.name, 'category' => 'openingweekend', 'measure' => m.openingweekend}
          
          @result2 << {'group' => m.name, 'category' => 'domesticgross', 'measure' => m.domesticgross}
          @result2 << {'group' => m.name, 'category' => 'foreigngross', 'measure' => m.foreigngross}
        end
        
        # @result2 << {'group' => m.name, 'category' => 'test', 'measure' => 1000}
      end
    else
      for i in (x.to_i-1)*50+1..x.to_i*50
        m = movies[i]
        if !m.nil?
          @result << [m.name, m.profitability]
          @result2 << {'group' => m.name, 'category' => 'budget', 'measure' => m.budget}
          @result2 << {'group' => m.name, 'category' => 'openingweekend', 'measure' => m.openingweekend}
          
          @result2 << {'group' => m.name, 'category' => 'domesticgross', 'measure' => m.domesticgross}
          @result2 << {'group' => m.name, 'category' => 'foreigngross', 'measure' => m.foreigngross}
        end
        
        # @result2 << {'group' => m.name, 'category' => 'test', 'measure' => 1000}
      end
    end
    
    # movies.each do |m|
      # @result << [m.name, m.profitability]
    # end
    
    # movies.each do |m|
      # # @result2 << {'group' => m.name, 'category' => 'numtheatres', 'measure' => m.numtheatres}
      # @result2 << {'group' => m.name, 'category' => 'budget', 'measure' => m.budget}
      # @result2 << {'group' => m.name, 'category' => 'openingweekend', 'measure' => m.openingweekend}
#       
      # @result2 << {'group' => m.name, 'category' => 'domesticgross', 'measure' => m.domesticgross}
      # @result2 << {'group' => m.name, 'category' => 'foreigngross', 'measure' => m.foreigngross}
    # end
    # @result2 << {'group' => 'All', 'category' => 'numtheatres', 'measure' => 0}
    @result2 << {'group' => 'All', 'category' => 'budget', 'measure' => 0}
    @result2 << {'group' => 'All', 'category' => 'openingweekend', 'measure' => 0}
    
    @result2 << {'group' => 'All', 'category' => 'domesticgross', 'measure' => 0}
    @result2 << {'group' => 'All', 'category' => 'foreigngross', 'measure' => 0}
    # @result2 << {'group' => 'All', 'category' => 'test', 'measure' => 1000}
  end
  
  
end

