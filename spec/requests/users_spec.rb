require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  
  describe "GET #new" do
    it "正常なレスポンスを返す" do
      get login_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
    end
  end
  
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status "302"
    end
  end
end
