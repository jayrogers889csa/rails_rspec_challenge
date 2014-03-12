require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "welcome page requires http authentication" do
      get :index
      expect(response.status).to eq 401
    end

    it "welcome page username is 'geek' and password is 'jock'" do
      user = 'geek'
      pw   = 'jock'
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)

      get :index
      expect(response.status).to eq 200
    end

    it "non-welcome pages do not require http auth" do
      get :new
      expect(response.status).to eq 200
    end
  end
end