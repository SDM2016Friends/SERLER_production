

Then(/^I click 'Search History' link and input 'Search name'$/) do
  expect(page).to have_button("Save Search")

  click_button 'save_search_btn'

  fill_in 'saved_search_name', with: 'Test1'
  click_link 'save_search_link'
  wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
  alert = wait.until { page.driver.browser.switch_to.alert  }
  alert.accept
  page.driver.browser.switch_to.alert.accept
end

Then(/^When I I click 'Search History', I am on history page and can see the item in a tabular form$/) do
  click_link 'search_history'
  expect(page).to have_content('Test1')
end

Then(/^I click 'Excute Search' and get the result$/) do
  page.find(:css, "tr:first-child .btn").click
  expect(page).to have_content('How')
end
