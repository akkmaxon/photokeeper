require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #feed" do
    it "returns http success" do
      get :feed
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #following" do
    it "returns http success" do
      get :following
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #followers" do
    it "returns http success" do
      get :followers
      expect(response).to have_http_status(:success)
    end
  end

end
