class GraphsController < ApplicationController
  @@spreadsheet = nil
  @@header = nil
  @@array = []
  @@filter = nil
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
  
  def main3
    children = []
    for i in 2007..2011
      moviesinyear = Movie.where(year: i)
      
      genres = moviesinyear.uniq.pluck(:genre)
     
      yearchildren = []
      genres.each do |g|
        moviesingenre = moviesinyear.where(genre: g)
        genrechildren = []
        stories = moviesingenre.uniq.pluck(:story)
        stories.each do |s|
          moviesinstory = moviesingenre.where(story: s)
          storyarray = []
          moviesinstory.each do |mis|
            storyarray << {'name'=> mis.name, 'size'=> mis.worldwidegross}
          end
          storyhash = {'name'=>s, 'children' => storyarray }
          genrechildren << storyhash
        end
        genrehash = {'name'=> g, 'children' => genrechildren}
        yearchildren << genrehash
      end
      yearhash = {'name'=>i.to_s, 'children' => yearchildren}
      children << yearhash
    end
    @result = {'name' => 'Movies', 'children' => children}
  end
  
  def main4
    children = []
    for i in 2007..2011
      moviesinyear = Movie.where(year: i)
      
      studios = moviesinyear.uniq.pluck(:studio)
     
      yearchildren = []
      studios.each do |s|
        moviesinstudio = moviesinyear.where(studio: s)
        studiochildren = []
        genres = moviesinstudio.uniq.pluck(:genre)
        genres.each do |g|
          moviesingenre = moviesinstudio.where(genre: g)
          genrearray = []
          moviesingenre.each do |mis|
            genrearray << {'name'=> mis.name, 'size'=> mis.worldwidegross}
          end
          genrehash = {'name'=>g, 'children' => genrearray }
          studiochildren << genrehash
        end
        studiohash = {'name'=> s, 'children' => studiochildren}
        yearchildren << studiohash
      end
      yearhash = {'name'=>i.to_s, 'children' => yearchildren}
      children << yearhash
    end
    @result = {'name' => 'Movies', 'children' => children}
  end
  
  def one
    
  end
  def two
    if !params[:filter].nil? && !params[:filter].empty?
      @test = true
      @header = @@header
      index = @@header.find_index(params[:filter])
      @values = @@spreadsheet.column(index+1).uniq
      @values.shift
      @@filter = params[:filter]
    else
      file = params[:file]
      @@spreadsheet = open_spreadsheet(file)
      @header = @@spreadsheet.row(1)
      @@header = @header
    end
    
    
  end
  def filter
    file = params[:file]
    @@spreadsheet = open_spreadsheet(file)
    @header = @@spreadsheet.row(1)
    @@header = @header
  end
  def three
    chosen = params[:chosen]
    filter = @@filter
    @x = params[:x]
    @y = params[:y]
    @@array = []
    (2..@@spreadsheet.last_row).each do |i|
      row = Hash[[@@header, @@spreadsheet.row(i)].transpose]
      if chosen.nil?
        @@array << [row[@x], row[@y]] if row[@y].to_d>=0
      else
        
        @@array << [row[@x], row[@y]] if (chosen.include? row[filter]) && row[@y].to_d>=0
        
      end
      
    end
    @sample = []
    size = @@array.size
    if size > 10
      size = 10
    end
    for i in 0..size-1
      
      @sample<<@@array[i]
    end
  end
  
  def pareto
    process = params[:process]
    @labels = []
    @data = []
    if process.nil? || process.empty?
      @@array.each do |a|
        @labels << a[0]
        @data << a[1]
      end
    else
      hash = {}
      @@array.each do |a|
        if hash.has_key?(a[0])
          if process == 'sum'
            hash[a[0]]+=a[1]
          elsif process == 'aggregate'
            hash[a[0]][0]+=a[1]
            hash[a[0]][1]+=1
          end
          
        else
            if process == 'sum'
              hash[a[0]]=a[1]
            elsif process == 'aggregate'
              hash[a[0]]=[a[1],1]
            end
        end
      end
      
      if process == 'sum'
        hash.each do |key, value|
          @labels << key
          @data << value
        
        end
      elsif process == 'aggregate'
        hash.each do |key, value|
          @labels << key
          @data << value[0]/value[1]  
        end    
      end
    end
    
  end
  
  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end

