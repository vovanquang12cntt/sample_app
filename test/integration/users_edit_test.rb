require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :macheal
  end

  test "unsuccessful edit" do
    get edit_user_path @user
    assert_template "users/edit"
    activated_at = Time.zone.today
    path users_path @user, params: {user: {name: "", email: "foo@invalid",
      password: "foo", password_confirmation: "baz", admin: true,
      activated: true, activated_at: activated_at}}
    assert_template "users/edit"
  end

  test "successful edit" do
    get edit_user_path @user
    assert_template "users/edit"
    name = "Foo Baz"
    email = "foobaz@gmail.com"
    activated_at = Time.zone.today
    path users_path @user, params: {user: {name: name, email: email,
      password: "", password_confirmation: "", admin: true,
      activated: true, activated_at: activated_at}}
    assert_not flash.empty?
    assert_redirect_to @user
    @user.reload
    asser_equal name, @user.name
    asser_equal email, @user.email
  end
end
