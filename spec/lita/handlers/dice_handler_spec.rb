require "spec_helper"

describe Lita::Handlers::DiceHandler, lita_handler: true do
  before { srand 1 }

  it 'rolls a single die' do
    send_command "roll d8"
    expect(replies.last).to eq("Rolled 6.")
  end

  it 'rolls a multiple dice' do
    send_command "roll 4d8"
    expect(replies.last).to eq("Rolled 6, 4, 5, and 1 for a total of 16.")
  end

  it 'adds a value to a single die' do
    send_command "roll d8+4"
    expect(replies.last).to eq("Rolled 6 for a total of 10.")
  end

  it 'adds a value to multiple dice' do
    send_command "roll 2d8+4"
    expect(replies.last).to eq("Rolled 6 and 4 for a total of 14.")
  end

  it 'subtracts a value to a single die' do
    send_command "roll d8-2"
    expect(replies.last).to eq("Rolled 6 for a total of 4.")
  end

  it 'subtracts a value to multiple dice' do
    send_command "roll 2d8-2"
    expect(replies.last).to eq("Rolled 6 and 4 for a total of 8.")
  end

  it 'drops the lowest die' do
    send_command "roll 3d8-L"
    expect(replies.last).to eq("Rolled 6, 4, and 5, dropped 4, for a total of 11.")
  end

  it 'complains about dropping the only die' do
    send_command "roll d8-L"
    expect(replies.last).to include("Don't be ridiculous")
  end



end
