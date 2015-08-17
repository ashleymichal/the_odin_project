require "../spec_helper"
require "../../lib/zombie"
describe Zombie do
  it "is named Ash" do
    zombie = Zombie.new
    expect zombie.name == 'Ash'
  end
  it "has no brains" do
    zombie = Zombie.new
    expect zombie.brains < 1
  end
  it "is not alive" do
    zombie = Zombie.new
    expect !zombie.alive
  end
  it "is rotting" do
    zombie = Zombie.new
    expect zombie.rotting
  end
  it "is five feet tall" do
    zombie = Zombie.new
    expect zombie.height > 5
  end
  it "is hungry" do
    zombie = Zombie.new
    expect zombie.hungry?
  end
end