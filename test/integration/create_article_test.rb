require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "john", email: "john@test.com", password: "123456", admin: false)
  end

  test 'get new article form and create article' do
    sign_in_as(@user, '123456')
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {title: "My title", description: "Description"}}
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match "My title", response.body
  end

  test 'invalid article submission results in failure' do
    sign_in_as(@user, '123456')
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: " ", description: " "}}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
