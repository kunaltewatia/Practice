require 'rails_helper'

RSpec.describe CountriesController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all countries as @countries' do
      country = Country.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:countries)).to eq([country])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested country as @country' do
      country = Country.create! valid_attributes
      get :show, { id: country.to_param }, valid_session
      expect(assigns(:country)).to eq(country)
    end
  end

  describe 'GET #new' do
    it 'assigns a new country as @country' do
      get :new, {}, valid_session
      expect(assigns(:country)).to be_a_new(Country)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested country as @country' do
      country = Country.create! valid_attributes
      get :edit, { id: country.to_param }, valid_session
      expect(assigns(:country)).to eq(country)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Country' do
        expect { post :create, { country: valid_attributes }, valid_session }
          .to change(Country, :count).by(1)
      end

      it 'assigns a newly created country as @country' do
        post :create, { country: valid_attributes }, valid_session
        expect(assigns(:country)).to be_a(Country)
        expect(assigns(:country)).to be_persisted
      end

      it 'redirects to the created country' do
        post :create, { country: valid_attributes }, valid_session
        expect(response).to redirect_to(Country.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved country as @country' do
        post :create, { country: invalid_attributes }, valid_session
        expect(assigns(:country)).to be_a_new(Country)
      end

      it "re-renders the 'new' template" do
        post :create, { country: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested country' do
        country = Country.create! valid_attributes
        put :update, { id: country.to_param, country: new_attributes },
            valid_session
        country.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested country as @country' do
        country = Country.create! valid_attributes
        put :update, { id: country.to_param, country: valid_attributes },
            valid_session
        expect(assigns(:country)).to eq(country)
      end

      it 'redirects to the country' do
        country = Country.create! valid_attributes
        put :update, { id: country.to_param, country: valid_attributes },
            valid_session
        expect(response).to redirect_to(country)
      end
    end

    context 'with invalid params' do
      it 'assigns the country as @country' do
        country = Country.create! valid_attributes
        put :update, { id: country.to_param, country: invalid_attributes },
            valid_session
        expect(assigns(:country)).to eq(country)
      end

      it "re-renders the 'edit' template" do
        country = Country.create! valid_attributes
        put :update, { id: country.to_param, country: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested country' do
      country = Country.create! valid_attributes
      expect { delete :destroy, { id: country.to_param }, valid_session }
        .to change(Country, :count).by(-1)
    end

    it 'redirects to the countries list' do
      country = Country.create! valid_attributes
      delete :destroy, { id: country.to_param }, valid_session
      expect(response).to redirect_to(countries_url)
    end
  end
end
