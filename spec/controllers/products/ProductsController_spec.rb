require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:valid_attributes) { { name: 'Sample Product' } }
  let(:invalid_attributes) { { name: '' } }
  let(:product) { Product.create(valid_attributes) }

  describe 'GET #index' do
    it 'assigns all products to @products and renders the index template' do
      product
      get :index
      expect(assigns(:products)).to include(product)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested product to @product and renders the show template' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new product to @product and renders the new template' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new product and redirects to the product page' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
        expect(response).to redirect_to(Product.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new product and re-renders the new template' do
        expect {
          post :create, params: { product: invalid_attributes }
        }.not_to change(Product, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested product to @product and renders the edit template' do
      get :edit, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the requested product and redirects to the product page' do
        patch :update, params: { id: product.id, product: { name: 'Updated Product' } }
        product.reload
        expect(product.name).to eq('Updated Product')
        expect(response).to redirect_to(product)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the product and re-renders the edit template' do
        patch :update, params: { id: product.id, product: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product and redirects to the products list' do
      product
      expect {
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(-1)
      expect(response).to redirect_to(products_path)
    end
  end
end
