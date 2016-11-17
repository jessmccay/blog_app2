require 'rails_helper'

RSpec.describe "blogs/new", type: :view do
  before(:each) do
    assign(:blog, Blog.new(
      :title => "MyString",
      :contents => "MyText",
      :user => nil
    ))
  end

  it "renders new blog form" do
    render

    assert_select "form[action=?][method=?]", blogs_path, "post" do

      assert_select "input#blog_title[name=?]", "blog[title]"

      assert_select "textarea#blog_contents[name=?]", "blog[contents]"

      assert_select "input#blog_user_id[name=?]", "blog[user_id]"
    end
  end
end
