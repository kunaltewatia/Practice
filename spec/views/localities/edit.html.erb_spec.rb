require 'rails_helper'

RSpec.describe 'localities/edit', type: :view do
  before(:each) do
    @locality = assign(:locality, Locality.create!(name: 'MyString', area: nil,
                                                   is_active: false))
  end

  it 'renders the edit locality form' do
    render

    assert_select 'form[action=?][method=?]',
                  locality_path(@locality), 'post' do
      assert_select 'input#locality_name[name=?]', 'locality[name]'

      assert_select 'input#locality_area_id[name=?]', 'locality[area_id]'

      assert_select 'input#locality_is_active[name=?]', 'locality[is_active]'
    end
  end
end
