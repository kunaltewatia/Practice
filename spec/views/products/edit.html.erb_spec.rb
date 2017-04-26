require 'rails_helper'

RSpec.describe 'products/edit', type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
                                  service: nil,
                                  name: 'MyString',
                                  origin: 'MyString',
                                  description: 'MyText',
                                  is_active: false))
  end

  it 'renders the edit product form' do
    render

    assert_select 'form[action=?][method=?]', product_path(@product), 'post' do
      assert_select 'input#product_service_id[name=?]', 'product[service_id]'

      assert_select 'input#product_name[name=?]', 'product[name]'

      assert_select 'input#product_origin[name=?]', 'product[origin]'

      assert_select 'textarea#product_description[name=?]',
                    'product[description]'

      assert_select 'input#product_is_active[name=?]', 'product[is_active]'
    end
  end
end
