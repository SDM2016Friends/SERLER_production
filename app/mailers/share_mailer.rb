class ShareMailer < ApplicationMailer
    def share_results_email(results, email)
        @results = results
        mail(to: email, :from => "sdm2016friends@163.com", subject: 'Results shared from SERLER!')
    end
end
