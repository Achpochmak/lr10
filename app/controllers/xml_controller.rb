# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
end

class XmlController < ApplicationController
  before_action :parse_params, only: :index

  def index
    palindromes = find_palindromes(@num)

    data = if palindromes.nil?
             { message: "Неверные параметры запроса (num = #{@num})" }
           else
             palindromes.map { |elem| { index: elem[0], num: elem[1], rev: elem[2], theory: elem[3] } }
           end

    respond_to do |format|
      format.html { render inline: data.to_s }
      format.xml { render xml: data.to_xml }
      format.rss { render xml: data.to_xml }
    end
  end

  protected

  def parse_params
    @num = params[:num]
  end

  private

  def find_palindromes(number)
    if @num = '' && @num.to_i.to_s != '0'
      @num = number.to_i.to_s
      @result = []
      i = 0
      while @num != @num.reverse && @result.size < 100
        i += 1
        @result << [i, @num, @num.reverse, 'Нет']
        @num = (@num.to_i + @num.reverse.to_i).to_s
      end
      @result << if @result.size != 100
                   [i+1, @num, @num.reverse, 'Да']
                 else
                   [i+1, @num, @num.reverse, 'Нет']
                 end
      @result
    else
      @result = false
    end
  end
end
