require 'rails_helper'

RSpec.describe HomeController, type: :controller do

    login_user
    let(:video1) { create(:video, user: subject.current_user) }

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
  
    it "should get index" do
      get 'index'
      expect(response).to be_succes
    end

    it "should count videos index" do
      get 'index'
      expect(assigns(:videos)).to eq([video1])
    end
  
end
