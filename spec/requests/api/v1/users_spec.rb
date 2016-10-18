require "rails_helper"

describe "Users API" do
  
  before :each do
  	@user = build(:user)
  end

  it "creates a new user" do
  	post api_user_registration_path, params: { nickname: @user.nickname, email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation }
  	
  	expect(response).to be_success
  	expect(json["data"]["email"]).to eq(@user.email)
  	expect(json["data"]["nickname"]).to eq(@user.nickname)
  end

  it "authenticates user" do
  	@user.save
  	post api_user_session_path, params: { email: @user.email, password: @user.password }

  	expect(response).to be_success
  	expect(@user.reload.tokens.count).to eq(1)
  end

  it "signs out successfully" do
  	@user.save
  	post api_user_session_path, params: { email: @user.email, password: @user.password }
  	
  	delete destroy_api_user_session_path, params: { "access-token": response.header["access-token"], client: response.header["client"], uid: response.header["uid"] }

  	expect(response).to be_success
  	expect(json["success"]).to be_truthy
  end

end