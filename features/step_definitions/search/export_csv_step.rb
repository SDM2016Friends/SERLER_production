Then(/^I can click 'Export'$/) do
  click_button 'export_csv'
end

Then(/^I should get a response with content\-type "([^"]*)"$/) do |arg1|

  #puts "*************** content = #{header}"
  #page.response_headers['Content-Type'].should == arg1

end

