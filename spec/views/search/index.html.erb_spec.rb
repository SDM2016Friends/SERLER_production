require 'rails_helper'

RSpec.describe "search/index.html.erb", type: :view do
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
  it 'displays search details correctly' do
    assign(:search, Search.create!({
      name: "Test",
      search_fields_attributes: [
        field: 'title',
        op2: 'ILIKE',
        content: 'How'
      ]}))
    render
    expect(rendered).to match /Title/
  end

  it 'displays show details correctly' do
    assign(:search, Search.new(search_fields_attributes: [
      field: 'title',
      op2: 'ILIKE',
      content: 'How'
    ]))
    user = User.create!(
      {
        email: "user@example.com", password: "123456", password_confirmation: "123456",
        reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1,
        current_sign_in_at: "2015-02-06 14:02:10", last_sign_in_at: "2015-02-06 14:02:10",
        current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", first_name: "Good", middle_name: "Profect",
        last_name: "Excellent"
      }
    )

    assign(:results, [
      EvidenceSource.new(
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
        }),
        EvidenceSource.new(
          {
            status: 'NEW', submitter_id: 1,
            title: 'resource Human',
            source_title: 'Communications of Animal',
            year: 1922, volume_number: 100, issue_number: 4,
            page_str: '274a-274a', page_begin: 100, page_cease: 300,
            DOI: '10.11029/FFFF.1922.180',
            category: 'Books',
            publisher: 'Atlanta, Ga. : Big Nerd Ranch, [1922]',
            published_time: DateTime.new(1922,12,12),
            rating_tenth: 9,
            research_aim: 'Education',
          })
    ])
    render
    expect(response).to match /Communications/
  end
end
