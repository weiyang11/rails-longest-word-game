require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letter = []
    i = 1
    until i > 10
      @letter << ('A'...'Z').to_a.sample
      i += 1
    end
    @letter
  end

  def score
    @grid = params[:grid]
    @input = params[:word]
    @answer = @input.upcase.chars.sort.all? { |letter| @grid.include?(letter) }
    if englishword(@input) && @answer
      @result = "<b> Congratulations! </b> #{@input.upcase} is a valid word!!".html_safe
    elsif englishword(@input) && !@answer
      @result = "Sorry but <b> #{@input.upcase} </b> can't built out of #{@grid}.".html_safe
    elsif !englishword(@input)
      @result = "Sorry but <b> #{@input.upcase} </b> does not seem to be a invalid English word...".html_safe
    end
  end

  def englishword(input)
    doc = URI.open("https://dictionary.lewagon.com/#{input}").read
    result = JSON.parse(doc)
    result['found']
  end
end
