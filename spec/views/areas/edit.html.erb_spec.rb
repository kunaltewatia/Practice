require 'rails_helper'

RSpec.describe 'areas/edit', type: :view do
  before(:each) do
    @area = assign(:area, Area.create!(name: 'MyString', city: nil,
                                       is_active: false))
  end

  it 'renders the edit area form' do
    render

    assert_select 'form[action=?][method=?]', area_path(@area), 'post' do
      assert_select 'input#area_name[name=?]', 'area[name]'

      assert_select 'input#area_city_id[name=?]', 'area[city_id]'

      assert_select 'input#area_is_active[name=?]', 'area[is_active]'
    end
  end
end
