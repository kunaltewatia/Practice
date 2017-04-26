require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all cities as @cities' do
      city = City.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:cities)).to eq([city])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested city as @city' do
      city = City.create! valid_attributes
      get :show, { id: city.to_param }, valid_session
      expect(assigns(:city)).to eq(city)
    end
  end

  describe 'GET #new' do
    it 'assigns a new city as @city' do
      get :new, {}, valid_session
      expect(assigns(:city)).to be_a_new(City)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested city as @city' do
      city = City.create! valid_attributes
      get :edit, { id: city.to_param }, valid_session
      expect(assigns(:city)).to eq(city)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new City' do
        expect { post :create, { city: valid_attributes }, valid_session }
          .to change(City, :count).by(1)
      end

      it 'assigns a newly created city as @city' do
        post :create, { city: valid_attributes }, valid_session
        expect(assigns(:city)).to be_a(City)
        expect(assigns(:city)).to be_persisted
      end

      it 'redirects to the created city' do
        post :create, { city: valid_attributes }, valid_session
        expect(response).to redirect_to(City.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved city as @city' do
        post :create, { city: invalid_attributes }, valid_session
        expect(assigns(:city)).to be_a_new(City)
      end

      it "re-renders the 'new' template" do
        post :create, { city: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested city' do
        city = City.create! valid_attributes
        put :update, { id: city.to_param, city: new_attributes },
            valid_session
        city.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested city as @city' do
        city = City.create! valid_attributes
        put :update, { id: city.to_param, city: valid_attributes },
            valid_session
        expect(assigns(:city)).to eq(city)
      end

      it 'redirects to the city' do
        city = City.create! valid_attributes
        put :update, { id: city.to_param, city: valid_attributes },
            valid_session
        expect(response).to redirect_to(city)
      end
    end

    context 'with invalid params' do
      it 'assigns the city as @city' do
        city = City.create! valid_attributes
        put :update, { id: city.to_param, city: invalid_attributes },
            valid_session
        expect(assigns(:city)).to eq(city)
      end

      it "re-renders the 'edit' template" do
        city = City.create! valid_attributes
        put :update, { id: city.to_param, city: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested city' do
      city = City.create! valid_attributes
      expect { delete :destroy, { id: city.to_param }, valid_session }
        .to change(City, :count).by(-1)
    end

    it 'redirects to the cities list' do
      city = City.create! valid_attributes
      delete :destroy, { id: city.to_param }, valid_session
      expect(response).to redirect_to(cities_url)
    end
  end
end
