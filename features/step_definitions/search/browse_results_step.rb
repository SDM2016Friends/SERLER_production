Given(/^There are (\d+) papers in DB$/) do |arg1|
  @user = User.create!({
    email: 'admin@admin.com',
    password: '12345678',
    password_confirmation: '12345678',
    first_name: 'Good',
    middle_name: 'Profect',
    last_name: 'Excellent'
  })
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

When(/^I visit browse page$/) do
	visit browse_path
end

Then(/^I can see (\d+) papers on page$/) do |arg1|
	expect(page).to have_content("How Colors", count: 3)
end
