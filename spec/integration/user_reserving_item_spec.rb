require 'spec_helper'

require 'spec_helper'

describe "A visitor" do
  it "must sign in"
end

describe "A signed in user" do
  before do
    # Sign in a user
  end

  describe "when other users have items" do
    describe "placing a reservation request" do
      describe "with good inputs" do
        it "succeeds"
      end
    end

    describe "editing a reservation request" do
      it "succeeds if the request is still pending"
      it "fails if the request is approved or denied"
    end
  end
end