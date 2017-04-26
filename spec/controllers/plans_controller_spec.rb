require 'rails_helper'

RSpec.describe PlansController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all plans as @plans' do
      plan = Plan.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:plans)).to eq([plan])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested plan as @plan' do
      plan = Plan.create! valid_attributes
      get :show, { id: plan.to_param }, valid_session
      expect(assigns(:plan)).to eq(plan)
    end
  end

  describe 'GET #new' do
    it 'assigns a new plan as @plan' do
      get :new, {}, valid_session
      expect(assigns(:plan)).to be_a_new(Plan)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested plan as @plan' do
      plan = Plan.create! valid_attributes
      get :edit, { id: plan.to_param }, valid_session
      expect(assigns(:plan)).to eq(plan)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Plan' do
        expect { post :create, { plan: valid_attributes }, valid_session }
          .to change(Plan, :count).by(1)
      end

      it 'assigns a newly created plan as @plan' do
        post :create, { plan: valid_attributes }, valid_session
        expect(assigns(:plan)).to be_a(Plan)
        expect(assigns(:plan)).to be_persisted
      end

      it 'redirects to the created plan' do
        post :create, { plan: valid_attributes }, valid_session
        expect(response).to redirect_to(Plan.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved plan as @plan' do
        post :create, { plan: invalid_attributes }, valid_session
        expect(assigns(:plan)).to be_a_new(Plan)
      end

      it "re-renders the 'new' template" do
        post :create, { plan: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested plan' do
        plan = Plan.create! valid_attributes
        put :update, { id: plan.to_param, plan: new_attributes }, valid_session
        plan.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested plan as @plan' do
        plan = Plan.create! valid_attributes
        put :update, { id: plan.to_param,  plan: valid_attributes },
            valid_session
        expect(assigns(:plan)).to eq(plan)
      end

      it 'redirects to the plan' do
        plan = Plan.create! valid_attributes
        put :update, { id: plan.to_param,  plan: valid_attributes },
            valid_session
        expect(response).to redirect_to(plan)
      end
    end

    context 'with invalid params' do
      it 'assigns the plan as @plan' do
        plan = Plan.create! valid_attributes
        put :update, { id: plan.to_param,  plan: invalid_attributes },
            valid_session
        expect(assigns(:plan)).to eq(plan)
      end

      it "re-renders the 'edit' template" do
        plan = Plan.create! valid_attributes
        put :update, { id: plan.to_param,  plan: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested plan' do
      plan = Plan.create! valid_attributes
      expect { delete :destroy, { id: plan.to_param }, valid_session }
        .to change(Plan, :count).by(-1)
    end

    it 'redirects to the plans list' do
      plan = Plan.create! valid_attributes
      delete :destroy, { id: plan.to_param }, valid_session
      expect(response).to redirect_to(plans_url)
    end
  end
end
