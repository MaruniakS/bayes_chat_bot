class HomeController < ApplicationController
  def index
    NaiveBayesClassifier.prepare_data
    sentence = 'hello, i want to become developer'
    render json: NaiveBayesClassifier.classify(sentence)
  end

  # def response
  #   @sentence = normalize_sentence(sentence_params[:sentence])
  #   render json: NaiveBayesClassifier.classify(@sentence)
  # end

  private
  # def sentence_params
  #   params.require(:training_data).permit(:sentence)
  # end

  def normalize_sentence(sentence)
    sentence.downcase.gsub(/[^a-z\s]/i, '')
  end
end
