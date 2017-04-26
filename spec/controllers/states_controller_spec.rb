require 'rails_helper'

RSpec.describe StatesController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all states as @states' do
      state = State.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:states)).to eq([state])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested state as @state' do
      state = State.create! valid_attributes
      get :show, { id: state.to_param }, valid_session
      expect(assigns(:state)).to eq(state)
    end
  end

  describe 'GET #new' do
    it 'assigns a new state as @state' do
      get :new, {}, valid_session
      expect(assigns(:state)).to be_a_new(State)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested state as @state' do
      state = State.create! valid_attributes
      get :edit, { id: state.to_param }, valid_session
      expect(assigns(:state)).to eq(state)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new State' do
        expect { post :create, { state: valid_attributes }, valid_session }
          .to change(State, :count).by(1)
      end

      it 'assigns a newly created state as @state' do
        post :create, { state: valid_attributes }, valid_session
        expect(assigns(:state)).to be_a(State)
        expect(assigns(:state)).to be_persisted
      end

      it 'redirects to the created state' do
        post :create, { state: valid_attributes }, valid_session
        expect(response).to redirect_to(State.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved state as @state' do
        post :create, { state: invalid_attributes }, valid_session
        expect(assigns(:state)).to be_a_new(State)
      end

      it "re-renders the 'new' template" do
        post :create, { state: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested state' do
        state = State.create! valid_attributes
        put :update, { id: state.to_param, state: new_attributes },
            valid_session
        state.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested state as @state' do
        state = State.create! valid_attributes
        put :update, { id: state.to_param, state: valid_attributes },
            valid_session
        expect(assigns(:state)).to eq(state)
      end

      it 'redirects to the state' do
        state = State.create! valid_attributes
        put :update, { id: state.to_param, state: valid_attributes },
            valid_session
        expect(response).to redirect_to(state)
      end
    end

    context 'with invalid params' do
      it 'assigns the state as @state' do
        state = State.create! valid_attributes
        put :update, { id: state.to_param, state: invalid_attributes },
            valid_session
        expect(assigns(:state)).to eq(state)
      end

      it "re-renders the 'edit' template" do
        state = State.create! valid_attributes
        put :update, { id: state.to_param, state: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested state' do
      state = State.create! valid_attributes
      expect { delete :destroy, { id: state.to_param }, valid_session }
        .to change(State, :count).by(-1)
    end

    it 'redirects to the states list' do
      state = State.create! valid_attributes
      delete :destroy, { id: state.to_param }, valid_session
      expect(response).to redirect_to(states_url)
    end
  end
end
