#!/usr/bin/env ruby

# Generates random numbers with a cosine component

include Math

require_relative '../generator.rb'


class CosGenerator < Generator

  def initialize(*args)
    super(*args)
     @random = Random.new(1234)
     @nn = 0.0
     @cosamp = 0.2

  end

  def self.summary
    "Generates random numbers with a cosine component"
  end

  def self.description
    desc = <<-DESC_END
    "Generates random numbers with a cosine component"
    DESC_END
    desc.gsub(/\s+/, " ").strip
  end

  def next_chunk
    @nn += (2*PI)/1000

    # random signal between 0 and (1.0 - @cosamp)
    random_component = (1.0 - @cosamp)*@random.rand

    # cosine signal between 0 and @cosamp
    cosine_component = @cosamp*(cos(@nn)/2 + 0.5)

    # Scale the signal to cover 12 bits
    sample = 2**10*(random_component + cosine_component)

    # Use only the lower 8 bits
    (sample.to_i & 0xFF).chr
  end
end

LcgGenerator.run if __FILE__ == $0
