class HomeController < ApplicationController
  def index
    NaiveBayesClassifier.prepare_data
    sentence = 'Hello, goodbye. See you'
    render json: NaiveBayesClassifier.classify(sentence)
  end

  private

  def normalize_sentence(sentence)
    sentence.downcase.gsub(/[^a-z\s]/i, '')
  end
end
