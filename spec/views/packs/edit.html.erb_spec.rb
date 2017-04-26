require 'rails_helper'

RSpec.describe 'packs/edit', type: :view do
  before(:each) do
    @pack = assign(:pack, Pack.create!(service: nil, name: 'MyString',
                                       description: 'MyText', is_active: false))
  end

  it 'renders the edit pack form' do
    render

    assert_select 'form[action=?][method=?]', pack_path(@pack), 'post' do
      assert_select 'input#pack_service_id[name=?]', 'pack[service_id]'

      assert_select 'input#pack_name[name=?]', 'pack[name]'

      assert_select 'textarea#pack_description[name=?]', 'pack[description]'

      assert_select 'input#pack_is_active[name=?]', 'pack[is_active]'
    end
  end
end
