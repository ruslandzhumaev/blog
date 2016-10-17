require "rails_helper"

describe "Users API" do
  
  it "creates a new user" do
  	user = build(:user)
  	post api_user_registration_path, params: { nickname: user.nickname, email: user.email, password: user.password, password_confirmation: user.password_confirmation }
  	
  	expect(response).to be_success
  	expect(json["data"]["email"]).to eq(user.email)
  	expect(json["data"]["nickname"]).to eq(user.nickname)
  end

end