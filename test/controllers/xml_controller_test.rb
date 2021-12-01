# frozen_string_literal: true

require 'test_helper'

class XmlControllerTest < ActionDispatch::IntegrationTest
  test 'check rss format' do
    get '/', params: { num: '263', format: :rss }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/rss'
  end
  test 'value_263' do
    get '/', params: { num: '263', format: :rss }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/rss'
    assert_equal 4, assigns(:result).size
    assert_equal [1, '263', '362', 'Нет'], assigns(:result)[0]
    assert_equal [2, '625', '526', 'Нет'], assigns(:result)[1]
    assert_equal [3, '1151', '1511', 'Нет'], assigns(:result)[2]
    assert_equal [4, '2662', '2662', 'Да'], assigns(:result)[3]
  end
end
