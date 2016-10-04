# Feature: View the results of a search
#     As a registered user
#     I want to be able to view the results of a search in a tabular format
#     So that I can view a lot of information easily.

Given(/^I'm logged in as a user at vr case$/) do
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

And(/^I'm on search page at vr case$/) do
  visit search_index_path
  #pending # Write code here that turns the phrase above into concrete actions
  expect(page).to have_button("Search")
end

And(/^There are (\d+) papers in DataBase at vr case$/) do |arg1|
  arg1.to_i.times do |i|
    EvidenceSource.create!(
        {
          status: 'NEW', submitter_id: 1,
          title: 'How Colors in Business Dashboards Affect Users Decision Making.',
          source_title: 'ommunications of the ACM. Apr2016, Vol. 59 Issue 4, p50-57. 8p. 1 Color Photograph, 4 Charts, 6 Graphs.',
          year: 2008, volume_number: 100, issue_number: 4,
          page_str: '274a-274a', page_begin: 100, page_cease: 300,
          DOI: '10.1145/2818993',
          category: 'Books',
          publisher: 'Atlanta, Ga. : Big Nerd Ranch, [1922]',
          published_time: DateTime.new(2008,12,12),
          rating_tenth: 9,
          research_aim: 'Ads.',
        })
  end
end

When(/^I type specific keywords and click search button at vr case$/) do
  fill_in 'search[search_fields_attributes][0][content]', with: 'ACM'
  within(".button-group") do
    click_button 'Search'
  end
end

Then(/^I should get specific results and I can view them in a tabular format at vr case$/) do
  expect(page).to have_selector("table.table")
end
