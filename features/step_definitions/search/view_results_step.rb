# Feature: View the results of a search
#     As a registered user
#     I want to be able to view the results of a search in a tabular format
#     So that I can view a lot of information easily.

Given(/^I'm logged in as a user at vr case$/) do
  @user = User.create!({
    email: 'admin@admin.com',
    password: '12345678',
    password_confirmation: '12345678'
  })
  @user.save!
  visit new_user_session_path
  expect(page).to have_content('Log in')

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: '12345678'
  click_button 'Log in'
end

And(/^I'm on search page at vr case$/) do
  visit root_path
  #pending # Write code here that turns the phrase above into concrete actions
  expect(page).to have_button("Search")
end

And(/^There are (\d+) papers in DataBase at vr case$/) do |arg1|
  arg1.to_i.times do |i|
    evidence = EvidenceSource.create!(
      {
        status: 'NEW', submitter_id: 1,
        title: 'From CMMI and Isolation to Scrum, Agile, Lean and Collaboration',
        source_title: 'Agile Conference, 2009. AGILE \'09.',
        year: 2009, volume_number: nil, issue_number: nil,
        page_str: '283-288', page_begin: 283, page_cease: 288,
        DOI: '10.1109/AGILE.2009.18',
      })
    evidence.save!
  end
end

When(/^I type specific keywords and click search button at vr case$/) do
  fill_in 'search[search_fields_attributes][0][content]', with: 'Agile'
  within(".button-group") do
    click_button 'Search'
  end
end

Then(/^I should get specific results and I can view them in a tabular format at vr case$/) do
  expect(page).to have_selector("table.table")
end
