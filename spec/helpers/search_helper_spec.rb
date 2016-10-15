require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SearchHelper. For example:
#
# describe SearchHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SearchHelper, type: :helper do
  before do
    controller.singleton_class.class_eval do
      protected
      def sort_column
        "title"
      end

      def sort_direction
        "desc"
      end

      helper_method :sort_column, :sort_direction
    end
  end

  describe "#sort_link" do
    it "returns proper link" do
      title = "Title"
      column = "title"
      expected = "data-sort=\"title\" data-direction=\"asc\" class=\"current desc\""
      expect(helper.sort_link(title, column)).to include(expected)
    end
  end
end
