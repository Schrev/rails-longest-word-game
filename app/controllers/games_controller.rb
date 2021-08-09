require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    source = ("A".."Z").to_a
    7.times { @letters << source.sample }
    vowel_source = %w[A E I O U]
    3.times { @letters << vowel_source.sample }
  end

  def english?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    url_response = URI.open(url).read
    response = JSON.parse(url_response)
    response['found']
  end

  def score
    @grid = params[:grid]
    @attempt = params[:score]
    @score = @attempt.chars.all? { |a| @grid.count(a.upcase) >= @attempt.chars.count(a) }
    @english = english?(@attempt)
    @points = 0
    @points = params[:score].size * params[:score].size if @score && @english
  end
end
