require 'rails_helper'

RSpec.describe PlanProductsController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all plan_products as @plan_products' do
      plan_product = PlanProduct.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:plan_products)).to eq([plan_product])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested plan_product as @plan_product' do
      plan_product = PlanProduct.create! valid_attributes
      get :show, { id: plan_product.to_param }, valid_session
      expect(assigns(:plan_product)).to eq(plan_product)
    end
  end

  describe 'GET #new' do
    it 'assigns a new plan_product as @plan_product' do
      get :new, {}, valid_session
      expect(assigns(:plan_product)).to be_a_new(PlanProduct)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested plan_product as @plan_product' do
      plan_product = PlanProduct.create! valid_attributes
      get :edit, { id: plan_product.to_param }, valid_session
      expect(assigns(:plan_product)).to eq(plan_product)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new PlanProduct' do
        expect do
          post :create, { plan_product: valid_attributes }, valid_session
        end.to change(PlanProduct, :count).by(1)
      end

      it 'assigns a newly created plan_product as @plan_product' do
        post :create, { plan_product: valid_attributes }, valid_session
        expect(assigns(:plan_product)).to be_a(PlanProduct)
        expect(assigns(:plan_product)).to be_persisted
      end

      it 'redirects to the created plan_product' do
        post :create, { plan_product: valid_attributes }, valid_session
        expect(response).to redirect_to(PlanProduct.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved plan_product as @plan_product' do
        post :create, { plan_product: invalid_attributes }, valid_session
        expect(assigns(:plan_product)).to be_a_new(PlanProduct)
      end

      it "re-renders the 'new' template" do
        post :create, { plan_product: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested plan_product' do
        plan_product = PlanProduct.create! valid_attributes
        put :update, { id: plan_product.to_param,
                       plan_product: new_attributes }, valid_session
        plan_product.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested plan_product as @plan_product' do
        plan_product = PlanProduct.create! valid_attributes
        put :update, { id: plan_product.to_param,
                       plan_product: valid_attributes }, valid_session
        expect(assigns(:plan_product)).to eq(plan_product)
      end

      it 'redirects to the plan_product' do
        plan_product = PlanProduct.create! valid_attributes
        put :update, { id: plan_product.to_param,
                       plan_product: valid_attributes }, valid_session
        expect(response).to redirect_to(plan_product)
      end
    end

    context 'with invalid params' do
      it 'assigns the plan_product as @plan_product' do
        plan_product = PlanProduct.create! valid_attributes
        put :update, { id: plan_product.to_param,
                       plan_product: invalid_attributes }, valid_session
        expect(assigns(:plan_product)).to eq(plan_product)
      end

      it "re-renders the 'edit' template" do
        plan_product = PlanProduct.create! valid_attributes
        put :update, { id: plan_product.to_param,
                       plan_product: invalid_attributes }, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested plan_product' do
      plan_product = PlanProduct.create! valid_attributes
      expect do
        delete :destroy, { id: plan_product.to_param }, valid_session
      end.to change(PlanProduct, :count).by(-1)
    end

    it 'redirects to the plan_products list' do
      plan_product = PlanProduct.create! valid_attributes
      delete :destroy, { id: plan_product.to_param }, valid_session
      expect(response).to redirect_to(plan_products_url)
    end
  end
end
