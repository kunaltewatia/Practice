require 'rails_helper'

RSpec.describe WingsController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all wings as @wings' do
      wing = Wing.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:wings)).to eq([wing])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested wing as @wing' do
      wing = Wing.create! valid_attributes
      get :show, { id: wing.to_param }, valid_session
      expect(assigns(:wing)).to eq(wing)
    end
  end

  describe 'GET #new' do
    it 'assigns a new wing as @wing' do
      get :new, {}, valid_session
      expect(assigns(:wing)).to be_a_new(Wing)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested wing as @wing' do
      wing = Wing.create! valid_attributes
      get :edit, { id: wing.to_param }, valid_session
      expect(assigns(:wing)).to eq(wing)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Wing' do
        expect { post :create, { wing: valid_attributes }, valid_session }
          .to change(Wing, :count).by(1)
      end

      it 'assigns a newly created wing as @wing' do
        post :create, { wing: valid_attributes }, valid_session
        expect(assigns(:wing)).to be_a(Wing)
        expect(assigns(:wing)).to be_persisted
      end

      it 'redirects to the created wing' do
        post :create, { wing: valid_attributes }, valid_session
        expect(response).to redirect_to(Wing.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved wing as @wing' do
        post :create, { wing: invalid_attributes }, valid_session
        expect(assigns(:wing)).to be_a_new(Wing)
      end

      it "re-renders the 'new' template" do
        post :create, { wing: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested wing' do
        wing = Wing.create! valid_attributes
        put :update, { id: wing.to_param, wing: new_attributes }, valid_session
        wing.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested wing as @wing' do
        wing = Wing.create! valid_attributes
        put :update, { id: wing.to_param, wing: valid_attributes },
            valid_session
        expect(assigns(:wing)).to eq(wing)
      end

      it 'redirects to the wing' do
        wing = Wing.create! valid_attributes
        put :update, { id: wing.to_param, wing: valid_attributes },
            valid_session
        expect(response).to redirect_to(wing)
      end
    end

    context 'with invalid params' do
      it 'assigns the wing as @wing' do
        wing = Wing.create! valid_attributes
        put :update, { id: wing.to_param, wing: invalid_attributes },
            valid_session
        expect(assigns(:wing)).to eq(wing)
      end

      it "re-renders the 'edit' template" do
        wing = Wing.create! valid_attributes
        put :update, { id: wing.to_param, wing: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested wing' do
      wing = Wing.create! valid_attributes
      expect { delete :destroy, { id: wing.to_param }, valid_session }
        .to change(Wing, :count).by(-1)
    end

    it 'redirects to the wings list' do
      wing = Wing.create! valid_attributes
      delete :destroy, { id: wing.to_param }, valid_session
      expect(response).to redirect_to(wings_url)
    end
  end
end
