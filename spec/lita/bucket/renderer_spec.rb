require 'spec_helper'

describe Bucket::Renderer do
  it 'replaces variables' do
    vars = double("Vars", get: double("Var", sample: "Whatever"))
    renderer = Bucket::Renderer.new(vars)
    expect(renderer.render("$foo")).to eq("Whatever")
  end
end
