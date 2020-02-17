require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user =  users(:john)
  end

  test "unsuccessful edit" do
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

  test 'successful edit' do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user:
                                          { name: 'Joe Smith',
                                            email: 'user@valid.com',
                                            password: '',
                                            password_confirmation: '' } }

    assert_redirected_to @user
    assert_not flash.empty?

    @user.reload
    assert_equal @user.name, 'Joe Smith'
    assert_equal @user.email, 'user@valid.com'
  end

end
