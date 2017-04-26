require 'rails_helper'

RSpec.describe MeasurementsController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all measurements as @measurements' do
      measurement = Measurement.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:measurements)).to eq([measurement])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested measurement as @measurement' do
      measurement = Measurement.create! valid_attributes
      get :show, { id: measurement.to_param }, valid_session
      expect(assigns(:measurement)).to eq(measurement)
    end
  end

  describe 'GET #new' do
    it 'assigns a new measurement as @measurement' do
      get :new, {}, valid_session
      expect(assigns(:measurement)).to be_a_new(Measurement)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested measurement as @measurement' do
      measurement = Measurement.create! valid_attributes
      get :edit, { id: measurement.to_param }, valid_session
      expect(assigns(:measurement)).to eq(measurement)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Measurement' do
        expect do
          post :create, { measurement: valid_attributes }, valid_session
        end
          .to change(Measurement, :count).by(1)
      end

      it 'assigns a newly created measurement as @measurement' do
        post :create, { measurement: valid_attributes }, valid_session
        expect(assigns(:measurement)).to be_a(Measurement)
        expect(assigns(:measurement)).to be_persisted
      end

      it 'redirects to the created measurement' do
        post :create, { measurement: valid_attributes }, valid_session
        expect(response).to redirect_to(Measurement.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved measurement as @measurement' do
        post :create, { measurement: invalid_attributes }, valid_session
        expect(assigns(:measurement)).to be_a_new(Measurement)
      end

      it "re-renders the 'new' template" do
        post :create, { measurement: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested measurement' do
        measurement = Measurement.create! valid_attributes
        put :update, { id: measurement.to_param, measurement: new_attributes },
            valid_session
        measurement.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested measurement as @measurement' do
        measurement = Measurement.create! valid_attributes
        put :update, { id: measurement.to_param,
                       measurement: valid_attributes }, valid_session
        expect(assigns(:measurement)).to eq(measurement)
      end

      it 'redirects to the measurement' do
        measurement = Measurement.create! valid_attributes
        put :update, { id: measurement.to_param,
                       measurement: valid_attributes }, valid_session
        expect(response).to redirect_to(measurement)
      end
    end

    context 'with invalid params' do
      it 'assigns the measurement as @measurement' do
        measurement = Measurement.create! valid_attributes
        put :update, { id: measurement.to_param,
                       measurement: invalid_attributes }, valid_session
        expect(assigns(:measurement)).to eq(measurement)
      end

      it "re-renders the 'edit' template" do
        measurement = Measurement.create! valid_attributes
        put :update, { id: measurement.to_param,
                       measurement: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested measurement' do
      measurement = Measurement.create! valid_attributes
      expect { delete :destroy, { id: measurement.to_param }, valid_session }
        .to change(Measurement, :count).by(-1)
    end

    it 'redirects to the measurements list' do
      measurement = Measurement.create! valid_attributes
      delete :destroy, { id: measurement.to_param }, valid_session
      expect(response).to redirect_to(measurements_url)
    end
  end
end
