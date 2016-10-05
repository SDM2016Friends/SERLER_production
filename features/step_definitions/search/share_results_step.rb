Then(/^I click 'Share Results' button$/) do
  expect(page).to have_button("Share Results")
  click_button 'share_results_btn'
end

Then(/^I input the email address and click 'Share' button$/) do
  fill_in 'Email', with: '644267777@qq.com'
  click_button 'share_btn'
end

Then(/^The search results should be shared by email$/) do
  expect(page).to have_content("Successful!!")
end
