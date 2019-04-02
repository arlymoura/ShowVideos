# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
    it 'take a new user' do
      get :new, params: params
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #edit' do
    let(:params) { { id: user1.id } }

    it 'assigns users' do
      get :edit, params: params
      expect(assigns(:user)).to eq(user1)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:params) { attributes_for(:user, email: Faker::Internet.email,
                              password: 'password', password_confirmation: 'password',
                              role: 'default') }

      it 'creates a new user' do
        expect { post :create, params: { user: params } }.to change(User, :count).by(1)
      end

      it 'redirect to index action template' do
        post :create, params: { user: params }
        expect(response).to redirect_to(users_path)
      end
    end

    context 'with invalid attributes' do
      let!(:params) { attributes_for(:user, email: nil) }

      it 'render new action template' do
        post :create, params: { user: params }
        expect(response).to render_template('users/new')
      end

      it 'does not create a new user' do
        expect { post :create, params: { user: params } }.not_to change(User, :count)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let!(:params) do
        { id: user1.id, user: { email: Faker::Internet.email,
                                role: 'admin' } }
      end

      it 'updates correctly the email' do
        expect { put :update, params: params; user1.reload }.to change(user1, :email)
      end

      it 'updates correctly the role' do
        expect { put :update, params: params; user1.reload }.to change(user1, :role)
      end

      it 'redirects to correctly route' do
        put :update, params: params
        expect(response).to redirect_to(users_path)
      end
    end

    context 'with invalid attributes' do
      let!(:params) do
        { id: user1.id, user: { email: nil,
                                role: nil } }
      end

      it 'does not update the email' do
        expect { user1.reload }.not_to change(user1, :email)
      end

      it 'does not update the customer_admin' do
        expect { user1.reload }.not_to change(user1, :role)
      end

      it 'render to correct template' do
        put :update, params: params
        expect(response).to render_template('users/edit')
      end
    end

    describe 'DELETE #destroy' do
      let(:params) { { id: user1.id } }

      it 'does delete the user' do
        delete :destroy, params: { id: user1.id }
        expect(response).to redirect_to(users_path)
      end
    end
  end
end
