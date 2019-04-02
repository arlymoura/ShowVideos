# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  include Devise::TestHelpers
  
  login_user
  let(:user1) { create(:user) }
  let(:video1) { create(:video, user: subject.current_user) }

  it 'should have a current_user' do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #index' do
    it 'should get index' do
      get 'index'
      expect(response).to be_succes
    end
  end

  describe 'GET #new' do
    let!(:params) { {} }
    it 'take a new video' do
      get :new, params: params
      expect(assigns(:video)).to be_a_new(Video)
    end
  end

  describe 'GET #edit' do
    let(:params) { { id: video1.id } }

    it 'assigns videos' do
      get :edit, params: params
      expect(assigns(:video)).to eq(video1)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:params) { attributes_for(:video, titulo: "teste", user_id: user1.id, views: 0,
                              url: "https://content.jwplatform.com/manifests/yp34SRmf.m3u8") }

      it 'creates a new video' do
        expect { post :create, params: { video: params } }.to change(Video, :count).by(1)
      end

    end
    
    context 'with invalid attributes' do
      let!(:params) { attributes_for(:video, titulo: nil) }

      it 'render new action template' do
        post :create, params: { video: params }
        expect(response).to render_template('videos/new')
      end

      it 'does not create a new videos' do
        expect { post :create, params: { video: params } }.not_to change(Video, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let!(:params) do
        { id: video1.id, video: { titulo: Faker::Movie.quote, user_id: user1.id,
          url: 'https://content2.jwplatform.com/manifests/yp34SRmf.m3u8' } }
      end

      it 'updates correctly the url' do
        expect { put :update, params: params; video1.reload }.to change(video1, :url)
      end

      it 'redirects to correctly route' do
        put :update, params: params
        expect(response).to redirect_to(video_path(video1))
      end
    end

    context 'with invalid attributes' do
      let!(:params) do
        { id: video1.id, video: { titulo: nil,
                                url: nil, user: nil } }
      end

      it 'does not update the titulo' do
        expect { video1.reload }.not_to change(video1, :titulo)
      end

      it 'does not update the url' do
        expect { video1.reload }.not_to change(video1, :url)
      end

      it 'does not update the user' do
        expect { video1.reload }.not_to change(video1, :user)
      end

      it 'render to correct template' do
        put :update, params: params
        expect(response).to render_template('videos/edit')
      end
    end

    describe 'DELETE #destroy' do
      let(:params) { { id: video1.id } }

      it 'does delete the user' do
        delete :destroy, params: params
        expect(response).to redirect_to(videos_path)
      end
    end
  end
end
