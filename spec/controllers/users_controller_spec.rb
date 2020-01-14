require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    context "未ログインユーザの場合" do
      it "レスポンスのステータスが302（失敗）である" do
        get :index
        expect(response).to have_http_status "302"
      end
    
      it "indexアクションを行うとログインページに遷移する" do
        get :index
        expect(response).to redirect_to "/login"
      end
    end
  end
end
