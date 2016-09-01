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

  it 'normalizes apostrophes' do
    send_command "it's random => BAR"
    send_message "something its random something"
    expect(replies.last).to eq("BAR")
  end

  it 'requires a word boundary' do
    send_command "foo => BAR"
    send_message "something foosball something"
    expect(replies.last).not_to eq("BAR")
  end

  it 'works with question marks' do
    send_command "foo? => BAR"
    send_message "fo"
    expect(replies.last).not_to eq("BAR")
    send_message "foo"
    expect(replies.last).not_to eq("BAR")
    send_message "foo?"
    expect(replies.last).to eq("BAR")
  end

  it 'keeps track of the last trigger' do
    send_command "foo => BAR"
    send_message "foo"
    expect(replies.last).to eq("BAR")
    send_command "what was that?"
    expect(replies.last).to eq("That was `foo => BAR`")
  end

  it 'can forget last retort' do
    send_command "foo => BAR"
    send_command "foo => BAZ"
    send_message "foo"
    last_reply = replies.last

    send_command "not funny"
    expect(replies.last).to eq("Yeah, I guess you're right. This factoid is gone: `foo => #{last_reply}`")

    send_command "literal foo"
    expect(replies.last).to eq("[0] #{last_reply == "BAR" ? "BAZ" : "BAR"}")
  end
end
