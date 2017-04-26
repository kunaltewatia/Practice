require 'rails_helper'

RSpec.describe 'societies/new', type: :view do
  before(:each) do
    assign(:society, Society.new(name: 'MyString',
                                 locality: nil,
                                 latitude: 'MyString',
                                 longlatitude: 'MyString',
                                 is_active: false))
  end

  it 'renders new society form' do
    render

    assert_select 'form[action=?][method=?]', societies_path, 'post' do
      assert_select 'input#society_name[name=?]', 'society[name]'

      assert_select 'input#society_locality_id[name=?]', 'society[locality_id]'

      assert_select 'input#society_latitude[name=?]', 'society[latitude]'

      assert_select 'input#society_longlatitude[name=?]',
                    'society[longlatitude]'

      assert_select 'input#society_is_active[name=?]', 'society[is_active]'
    end
  end
end
