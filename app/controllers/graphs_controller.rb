class GraphsController < ApplicationController
  def main
    value = []
    
    for i in 1..25
      value << {"x" => rand(30), 'y' => rand(30), 'size' => rand(10), 'shape' => 'circle'}
    end
    hash = {'key' => 'Comedy', 'values' => value}
    @data = []
    @data << hash
  end
end
