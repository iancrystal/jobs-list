require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.

  test "acts as tree" do
    assert_nil categories(:root).parent
    assert_equal categories(:finance).parent.name, "All Jobs"
    assert_equal categories(:technology).parent.name, "All Jobs"
    assert_equal categories(:root).children.first.children.first.name, "accounting"
  end

  test "descendants" do
    descendants =  categories(:root).descendants.map {|child| child.name }.sort.join(" ")
    assert_equal "accounting finance payroll technology", descendants
  end

  test "category array" do
    assert_equal Category.category_array[3][0], "finance:accounting:payroll"
  end

end
