require 'rails_helper'

RSpec.describe SocietiesController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all societies as @societies' do
      society = Society.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:societies)).to eq([society])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested society as @society' do
      society = Society.create! valid_attributes
      get :show, { id: society.to_param }, valid_session
      expect(assigns(:society)).to eq(society)
    end
  end

  describe 'GET #new' do
    it 'assigns a new society as @society' do
      get :new, {}, valid_session
      expect(assigns(:society)).to be_a_new(Society)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested society as @society' do
      society = Society.create! valid_attributes
      get :edit, { id: society.to_param }, valid_session
      expect(assigns(:society)).to eq(society)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Society' do
        expect { post :create, { society: valid_attributes }, valid_session }
          .to change(Society, :count).by(1)
      end

      it 'assigns a newly created society as @society' do
        post :create, { society: valid_attributes }, valid_session
        expect(assigns(:society)).to be_a(Society)
        expect(assigns(:society)).to be_persisted
      end

      it 'redirects to the created society' do
        post :create, { society: valid_attributes }, valid_session
        expect(response).to redirect_to(Society.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved society as @society' do
        post :create, { society: invalid_attributes }, valid_session
        expect(assigns(:society)).to be_a_new(Society)
      end

      it "re-renders the 'new' template" do
        post :create, { society: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested society' do
        society = Society.create! valid_attributes
        put :update, { id: society.to_param, society: new_attributes },
            valid_session
        society.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested society as @society' do
        society = Society.create! valid_attributes
        put :update, { id: society.to_param, society: valid_attributes },
            valid_session
        expect(assigns(:society)).to eq(society)
      end

      it 'redirects to the society' do
        society = Society.create! valid_attributes
        put :update, { id: society.to_param, society: valid_attributes },
            valid_session
        expect(response).to redirect_to(society)
      end
    end

    context 'with invalid params' do
      it 'assigns the society as @society' do
        society = Society.create! valid_attributes
        put :update, { id: society.to_param, society: invalid_attributes },
            valid_session
        expect(assigns(:society)).to eq(society)
      end

      it "re-renders the 'edit' template" do
        society = Society.create! valid_attributes
        put :update, { id: society.to_param, society: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested society' do
      society = Society.create! valid_attributes
      expect { delete :destroy, { id: society.to_param }, valid_session }
        .to change(Society, :count).by(-1)
    end

    it 'redirects to the societies list' do
      society = Society.create! valid_attributes
      delete :destroy, { id: society.to_param }, valid_session
      expect(response).to redirect_to(societies_url)
    end
  end
end
