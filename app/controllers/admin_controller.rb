class AdminController < ApplicationController
  def loaddata
    read_file("C:/Users/Terence Chu/Dropbox/work/Rails Projects/Ecureuil/public/datum.csv").each{ |line|
      a = line.split(",")
      begin
        Movie.create(name: a[0], studio: a[1], rotten: a[2].to_i, audience: a[3].to_i, story: a[4], genre: a[5], numtheatres: a[6].to_i,
        boxaverage: a[7].to_i, domesticgross: a[8].to_d, foreigngross: a[9].to_d, worldwidegross: a[10].to_d, budget: a[11].to_d,
        profitability: a[12].to_d, openingweekend: a[13].to_d)
      rescue
        
      end

    }
  end
  
  def loaddata
    read_file("C:/Users/Terence Chu/Dropbox/work/Rails Projects/Ecureuil/public/datayears.csv").each{ |line|
      a = line.split(",")
      @b = []
      begin
        
      rescue
        
      end
      m = Movie.find_by_name(a[0])
      if m.nil?
        @b << m
      end
      m.update_attribute(:year, a[1].to_i) if !m.nil?
    }
  end

  def read_file(file)
    lines = IO.readlines(file)
    if lines != nil
      for i in 0 .. lines.length-1
        lines[i] = lines[i].sub("\n","")
      end
    return lines[0..lines.length-1]
    end
    return nil
  end
end
