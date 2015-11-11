require "spec_helper"

describe Lita::Handlers::FactoidHandler, lita_handler: true do
  it 'remembers factoids' do
    send_command "you are annoying => who, me?"
    expect(replies.last).to eq("Okay.")
  end

  it 'triggers on normal messages' do
    send_command "foo => BAR"
    send_message "something foo something"
    expect(replies.last).to eq("BAR")
  end

  it 'normalizes uppercase' do
    send_command "FOO => BAR"
    send_message "something foo something"
    expect(replies.last).to eq("BAR")
  end

  it 'normalizes uppercase' do
    send_command "it's random => BAR"
    send_message "something its random something"
    expect(replies.last).to eq("BAR")
  end

  it 'requires a word boundary uppercase' do
    send_command "foo => BAR"
    send_message "something foosball something"
    expect(replies.last).not_to eq("BAR")
  end

  it 'works with question marks' do
    pending
    send_command "foo? => BAR"
    send_message "fo"
    expect(replies.last).not_to eq("BAR")
    send_message "foo"
    expect(replies.last).not_to eq("BAR")
    send_message "foo?"
    expect(replies.last).to eq("BAR")
  end
end
