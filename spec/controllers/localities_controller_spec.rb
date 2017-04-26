require 'rails_helper'
RSpec.describe LocalitiesController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all localities as @localities' do
      locality = Locality.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:localities)).to eq([locality])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested locality as @locality' do
      locality = Locality.create! valid_attributes
      get :show, { id: locality.to_param }, valid_session
      expect(assigns(:locality)).to eq(locality)
    end
  end

  describe 'GET #new' do
    it 'assigns a new locality as @locality' do
      get :new, {}, valid_session
      expect(assigns(:locality)).to be_a_new(Locality)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested locality as @locality' do
      locality = Locality.create! valid_attributes
      get :edit, { id: locality.to_param }, valid_session
      expect(assigns(:locality)).to eq(locality)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Locality' do
        expect { post :create, { locality: valid_attributes }, valid_session }
          .to change(Locality, :count).by(1)
      end

      it 'assigns a newly created locality as @locality' do
        post :create, { locality: valid_attributes }, valid_session
        expect(assigns(:locality)).to be_a(Locality)
        expect(assigns(:locality)).to be_persisted
      end

      it 'redirects to the created locality' do
        post :create, { locality: valid_attributes }, valid_session
        expect(response).to redirect_to(Locality.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved locality as @locality' do
        post :create, { locality: invalid_attributes }, valid_session
        expect(assigns(:locality)).to be_a_new(Locality)
      end

      it "re-renders the 'new' template" do
        post :create, { locality: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested locality' do
        locality = Locality.create! valid_attributes
        put :update, { id: locality.to_param, locality: new_attributes },
            valid_session
        locality.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested locality as @locality' do
        locality = Locality.create! valid_attributes
        put :update, { id: locality.to_param, locality: valid_attributes },
            valid_session
        expect(assigns(:locality)).to eq(locality)
      end

      it 'redirects to the locality' do
        locality = Locality.create! valid_attributes
        put :update, { id: locality.to_param, locality: valid_attributes },
            valid_session
        expect(response).to redirect_to(locality)
      end
    end

    context 'with invalid params' do
      it 'assigns the locality as @locality' do
        locality = Locality.create! valid_attributes
        put :update, { id: locality.to_param, locality: invalid_attributes },
            valid_session
        expect(assigns(:locality)).to eq(locality)
      end

      it "re-renders the 'edit' template" do
        locality = Locality.create! valid_attributes
        put :update, { id: locality.to_param, locality: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested locality' do
      locality = Locality.create! valid_attributes
      expect { delete :destroy, { id: locality.to_param }, valid_session }
        .to change(Locality, :count).by(-1)
    end

    it 'redirects to the localities list' do
      locality = Locality.create! valid_attributes
      delete :destroy, { id: locality.to_param }, valid_session
      expect(response).to redirect_to(localities_url)
    end
  end
end
