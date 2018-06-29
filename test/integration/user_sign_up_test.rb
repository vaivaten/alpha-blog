require 'test_helper'

class UserSignUpTest < ActionDispatch::IntegrationTest

  test 'successful sign up' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: "john", email: "john@test.com", password: "123456"}}
      follow_redirect!
    end
    assert_template 'users/show'
    assert_match "Welcome to the Blog, john!", response.body
  end

  test 'unsuccessful sign up' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {username: " ", email: " ", password: " "}}
    end
    assert_template 'users/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
