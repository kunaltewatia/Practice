require 'rails_helper'

RSpec.describe 'packs/new', type: :view do
  before(:each) do
    assign(:pack, Pack.new(service: nil, name: 'MyString',
                           description: 'MyText', is_active: false))
  end

  it 'renders new pack form' do
    render

    assert_select 'form[action=?][method=?]', packs_path, 'post' do
      assert_select 'input#pack_service_id[name=?]', 'pack[service_id]'

      assert_select 'input#pack_name[name=?]', 'pack[name]'

      assert_select 'textarea#pack_description[name=?]', 'pack[description]'

      assert_select 'input#pack_is_active[name=?]', 'pack[is_active]'
    end
  end
end
