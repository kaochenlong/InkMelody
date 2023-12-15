# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'hi@aa.cc'
  layout 'mailer'
end
