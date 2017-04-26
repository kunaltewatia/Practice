require 'rails_helper'

RSpec.describe 'localities/new', type: :view do
  before(:each) do
    assign(:locality, Locality.new(name: 'MyString', area: nil,
                                   is_active: false))
  end

  it 'renders new locality form' do
    render

    assert_select 'form[action=?][method=?]', localities_path, 'post' do
      assert_select 'input#locality_name[name=?]', 'locality[name]'

      assert_select 'input#locality_area_id[name=?]', 'locality[area_id]'

      assert_select 'input#locality_is_active[name=?]', 'locality[is_active]'
    end
  end
end
