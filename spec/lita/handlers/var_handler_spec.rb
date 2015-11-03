require "spec_helper"

describe Lita::Handlers::VarHandler, lita_handler: true do
  it 'lists vars' do
    send_command "var list $bodypart"
    expect(replies.last).to match(/I can fill in these variables/)
  end

  # it 'listens to messages and completes vars when a known one is mentioned' do
  #   send_message "just take your $animal to $place"
  #   expect(replies.last).to match(/yeah, just take your .+ to .+/)
  # end
end
