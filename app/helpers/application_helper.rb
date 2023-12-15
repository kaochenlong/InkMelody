# frozen_string_literal: true

module ApplicationHelper
  def qrcode(text)
    tag.canvas data: { controller: 'qrcode', text: }
  end
end
