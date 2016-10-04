#Feature: Search For Empirical Evidence
  #As a registered user
  #I want to be able to search for empirical evidence on different methods based on different constraints
  #So that I can make informed decisions

Given(/^I'm logged in as a user$/) do
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

Given(/^There are (\d+) papers in DB\$$/) do |arg1|
  arg1.to_i.times do |i|
    evidence = EvidenceSource.create!(
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
    evidence.save!
  end
end

Given(/^I'm on search page$/) do
  visit search_index_path
  #pending # Write code here that turns the phrase above into concrete actions
  expect(page).to have_button("Search")
end

When(/^I type specific keywords and click search button$/) do
  fill_in 'search[search_fields_attributes][0][content]', with: 'ACM'
  within(".button-group") do
    click_button 'Search'
  end
end

Then(/^I should get specific results$/) do
  expect(page).to have_content('How Colors')
end
