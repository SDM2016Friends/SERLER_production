# Feature: Show and hide the columns of searching results by user
# As a registered user
# I want to be able to select what columns are visible in a displayed search
# So I can experiment with what is visible

Given(/^I'm logged in as a user on select_column case$/) do
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

And (/^There are (\d+) papers in DB on select_column case$/) do |arg1|
  arg1.to_i.times do |i|
    evidence = EvidenceSource.create!(
        {
            status: 'NEW', submitter_id: 1,
            title: 'From CMMI and Isolation to Scrum, Agile, Lean and Collaboration',
            source_title: 'Agile Conference, 2009. AGILE \'09.',
            published_time: '2009-10-01',
            year: 2009, volume_number: nil, issue_number: nil,
            page_str: '283-288', page_begin: 283, page_cease: 288,
            DOI: '10.1109/AGILE.2009.18',
        })
    evidence.save!
  end
end

And (/^I'm on search page on select_column case$/) do
  visit search_index_path
  expect(page).to have_button("Search")
end

And (/^I type specific keywords and click search button on select_column case$/) do
  fill_in 'search[search_fields_attributes][0][content]', with: ''
  within(".button-group") do
    click_button 'Search'
  end
end

When(/^I canceled a checkbox of a column$/) do
  page.find(:xpath, "(//td[@class='title_header'])[2]", :visible => true)
  page.find(:xpath, "(//div[@class='btn-group'])").click_on
  page.find(:xpath, "(//input[@type='checkbox'])[1]").click
end

Then(/^The column hides$/) do
  page.find(:xpath, "(//td[@class='title_header'])[2]", :visible => false)
end