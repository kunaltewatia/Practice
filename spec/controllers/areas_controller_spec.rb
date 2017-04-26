require 'rails_helper'

RSpec.describe AreasController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all areas as @areas' do
      area = Area.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:areas)).to eq([area])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested area as @area' do
      area = Area.create! valid_attributes
      get :show, { id: area.to_param }, valid_session
      expect(assigns(:area)).to eq(area)
    end
  end

  describe 'GET #new' do
    it 'assigns a new area as @area' do
      get :new, {}, valid_session
      expect(assigns(:area)).to be_a_new(Area)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested area as @area' do
      area = Area.create! valid_attributes
      get :edit, { id: area.to_param }, valid_session
      expect(assigns(:area)).to eq(area)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Area' do
        expect { post :create, { area: valid_attributes }, valid_session }
          .to change(Area, :count).by(1)
      end

      it 'assigns a newly created area as @area' do
        post :create, { area: valid_attributes }, valid_session
        expect(assigns(:area)).to be_a(Area)
        expect(assigns(:area)).to be_persisted
      end

      it 'redirects to the created area' do
        post :create, { area: valid_attributes }, valid_session
        expect(response).to redirect_to(Area.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved area as @area' do
        post :create, { area: invalid_attributes }, valid_session
        expect(assigns(:area)).to be_a_new(Area)
      end

      it "re-renders the 'new' template" do
        post :create, { area: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested area' do
        area = Area.create! valid_attributes
        put :update, { id: area.to_param, area: new_attributes },
            valid_session
        area.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested area as @area' do
        area = Area.create! valid_attributes
        put :update, { id: area.to_param, area: valid_attributes },
            valid_session
        expect(assigns(:area)).to eq(area)
      end

      it 'redirects to the area' do
        area = Area.create! valid_attributes
        put :update, { id: area.to_param, area: valid_attributes },
            valid_session
        expect(response).to redirect_to(area)
      end
    end

    context 'with invalid params' do
      it 'assigns the area as @area' do
        area = Area.create! valid_attributes
        put :update, { id: area.to_param, area: invalid_attributes },
            valid_session
        expect(assigns(:area)).to eq(area)
      end

      it "re-renders the 'edit' template" do
        area = Area.create! valid_attributes
        put :update, { id: area.to_param, area: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested area' do
      area = Area.create! valid_attributes
      expect { delete :destroy, { id: area.to_param }, valid_session }
        .to change(Area, :count).by(-1)
    end

    it 'redirects to the areas list' do
      area = Area.create! valid_attributes
      delete :destroy, { id: area.to_param }, valid_session
      expect(response).to redirect_to(areas_url)
    end
  end
end
