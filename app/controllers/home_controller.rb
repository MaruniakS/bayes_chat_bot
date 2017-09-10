class HomeController < ApplicationController
  def index
    sentence = 'how is your installation'.split(' ')
    @stems = Lingua.stemmer(sentence)
    render json: @stems.as_json
  end
end
