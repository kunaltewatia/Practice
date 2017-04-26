require 'rails_helper'

RSpec.describe PacksController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all packs as @packs' do
      pack = Pack.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:packs)).to eq([pack])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested pack as @pack' do
      pack = Pack.create! valid_attributes
      get :show, { id: pack.to_param }, valid_session
      expect(assigns(:pack)).to eq(pack)
    end
  end

  describe 'GET #new' do
    it 'assigns a new pack as @pack' do
      get :new, {}, valid_session
      expect(assigns(:pack)).to be_a_new(Pack)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested pack as @pack' do
      pack = Pack.create! valid_attributes
      get :edit, { id: pack.to_param }, valid_session
      expect(assigns(:pack)).to eq(pack)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Pack' do
        expect { post :create, { pack: valid_attributes }, valid_session }
          .to change(Pack, :count).by(1)
      end

      it 'assigns a newly created pack as @pack' do
        post :create, { pack: valid_attributes }, valid_session
        expect(assigns(:pack)).to be_a(Pack)
        expect(assigns(:pack)).to be_persisted
      end

      it 'redirects to the created pack' do
        post :create, { pack: valid_attributes }, valid_session
        expect(response).to redirect_to(Pack.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved pack as @pack' do
        post :create, { pack: invalid_attributes }, valid_session
        expect(assigns(:pack)).to be_a_new(Pack)
      end

      it "re-renders the 'new' template" do
        post :create, { pack: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested pack' do
        pack = Pack.create! valid_attributes
        put :update, { id: pack.to_param, pack: new_attributes }, valid_session
        pack.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested pack as @pack' do
        pack = Pack.create! valid_attributes
        put :update, { id: pack.to_param,  pack: valid_attributes },
            valid_session
        expect(assigns(:pack)).to eq(pack)
      end

      it 'redirects to the pack' do
        pack = Pack.create! valid_attributes
        put :update, { id: pack.to_param,  pack: valid_attributes },
            valid_session
        expect(response).to redirect_to(pack)
      end
    end

    context 'with invalid params' do
      it 'assigns the pack as @pack' do
        pack = Pack.create! valid_attributes
        put :update, { id: pack.to_param,  pack: invalid_attributes },
            valid_session
        expect(assigns(:pack)).to eq(pack)
      end

      it "re-renders the 'edit' template" do
        pack = Pack.create! valid_attributes
        put :update, { id: pack.to_param, pack: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested pack' do
      pack = Pack.create! valid_attributes
      expect { delete :destroy, { id: pack.to_param }, valid_session }
        .to change(Pack, :count).by(-1)
    end

    it 'redirects to the packs list' do
      pack = Pack.create! valid_attributes
      delete :destroy, { id: pack.to_param }, valid_session
      expect(response).to redirect_to(packs_url)
    end
  end
end
