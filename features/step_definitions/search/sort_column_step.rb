# Feature: Sort column for searching results
#   As a registered user
#   I want to be able to easily sort the displayed results of a search by any field I want
#   So I can experiment with what is useful.

Given(/^I'm logged in as a user on sort_column case$/) do
  @user = User.create!({
                           email: 'admin@admin.com',
                           password: '12345678',
                           password_confirmation: '12345678',
                           first_name: 'Good',
                           middle_name: 'Profect',
                           last_name: 'Excellent'
                       })
  @user.save!
  visit new_user_session_path
  expect(page).to have_content('Log in')

  fill_in 'Email', with: @user.email
  fill_in 'Password', with: '12345678'
  click_button 'Log in'
end

Given(/^I'm on search page on sort_column case$/) do
  visit search_index_path
  expect(page).to have_button("Search")
end

Given(/^There are 3 papers in DB on sort_column case$/) do
  evidence = EvidenceSource.create!(
      {
          status: 'NEW', submitter_id: 1,
          title: 'Resource Human',
          source_title: 'Agile Conference, 2009. AGILE \'09.',
          year: 2009, volume_number: nil, issue_number: nil,
          page_str: '283-288', page_begin: 283, page_cease: 288,
          DOI: '10.1109/AGILE.2009.18',
      })

  evidence = EvidenceSource.create!(
      {
          status: 'NEW', submitter_id: 1,
          title: 'OBJC What is problem?',
          source_title: 'Agile Conference, 2009. AGILE \'09.',
          year: 2009, volume_number: nil, issue_number: nil,
          page_str: '283-288', page_begin: 283, page_cease: 288,
          DOI: '10.1109/AGILE.2009.18',
      })

  evidence = EvidenceSource.create!(
      {
          status: 'NEW', submitter_id: 1,
          title: 'A study of pair-programming configuration for learning computer networks',
          source_title: 'Agile Conference, 2009. AGILE \'09.',
          year: 2009, volume_number: nil, issue_number: nil,
          page_str: '283-288', page_begin: 283, page_cease: 288,
          DOI: '10.1109/AGILE.2009.18',
      })

  evidence.save!
end

When(/^I type specific keywords and click search button on sort_column case$/) do
  fill_in 'search[search_fields_attributes][0][content]', with: ''
  within(".button-group") do
    click_button 'Search'
  end
end

And(/^click the column which I want to sort$/) do
  find(:xpath, "(//table[@class='table']/tbody/tr[1]/td[1])").text.should eq('A study of pair-programming configuration for learning computer networks')
  find(:xpath, "(//table[@class='table']/thead/tr/td[1]/a)").click
end

Then(/^The results can be sorted$/) do
 # page.find(:xpath, "(//table[@class='table']/tbody/tr[1]/td[1])").text.should eq('Resource Human')
end
