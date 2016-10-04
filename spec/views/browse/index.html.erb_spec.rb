require 'rails_helper'

RSpec.describe "browse/index.html.erb", type: :view do
  it 'displays show details correctly' do
    user = User.create!(
      {
        email: "user@example.com", password: "123456", password_confirmation: "123456",
        reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1,
        current_sign_in_at: "2015-02-06 14:02:10", last_sign_in_at: "2015-02-06 14:02:10",
        current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", first_name: "1", middle_name: "2", 
        last_name: "3"
      }
    )
    EvidenceSource.create!(
      {
        status: 'NEW', submitter_id: user.id,
        title: 'From CMMI and Isolation to Scrum, Agile, Lean and Collaboration',
        source_title: 'Agile Conference, 2009. AGILE \'09.',
        year: 2009, volume_number: nil, issue_number: nil,
        page_str: '283-288', page_begin: 283, page_cease: 288,
        DOI: '10.1109/AGILE.2009.18',
      })
    EvidenceSource.create!(
      {
        status: 'NEW', submitter_id: user.id,
        title: 'From CMMI and Isolation to Scrum, Agile, Lean and Collaboration',
        source_title: 'Agile Conference, 2009. AGILE \'09.',
        year: 2009, volume_number: nil, issue_number: nil,
        page_str: '283-288', page_begin: 283, page_cease: 288,
        DOI: '10.1109/AGILE.2009.18',
      })
    assign(:evidence_sources, EvidenceSource.order(created_at: :desc).page())
    render
    expect(response).to match /Agile/
  end
end
