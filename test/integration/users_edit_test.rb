# frozen_string_literal: true

require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test 'unsuccessful edit' do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user:
                                          { name: '',
                                            email: 'user@invalid',
                                            password: 'blah',
                                            password_confirmation: 'aaaaaa' } }
    assert_template 'users/edit'
  end

  test 'successful edit with friendly forward' do
    get edit_user_path(@user)
    log_in_as @user
    assert_redirected_to edit_user_url(@user)
    name = 'ginger'
    email = 'ginge@shihtzu.io'
    patch user_path(@user), params: { user:
                                          { name: name,
                                            email: email,
                                            password: '',
                                            password_confirmation: '' } }

    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
