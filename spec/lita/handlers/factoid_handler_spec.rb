require "spec_helper"

describe Lita::Handlers::FactoidHandler, lita_handler: true do
  it 'remembers factoids' do
    send_command "you are annoying => who, me?"
    expect(replies.last).to eq("Okay.")
  end
end
