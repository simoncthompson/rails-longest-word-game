require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letter_grid = generate_grid
  end

  def score
    @answer = params[:answer]
    @score = calculate_score(@answer, new)
  end

  private

  def generate_grid
    ('A'..'Z').to_a.sample(10)
  end

  def calculate_score(word, grid)
    if english_word?(word) && word_in_grid?(word.split(''), grid.map { |letter| letter.downcase })
      'Great job'
    else
      'Invalid guess - not in grid, or not an English word.'
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = JSON.parse(URI.open(url).read)
    response['found'] ? true : false
  end

  def word_in_grid?(word, grid)
    result = (word - grid)
    result.empty? ? true : false
    raise
  end
end
