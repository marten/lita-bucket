require "spec_helper"

describe Lita::Handlers::VarHandler, lita_handler: true do
  it 'lists vars' do
    send_command "var list $bodypart"
    expect(replies.last).to match(/I can fill in these variables/)
  end
end
