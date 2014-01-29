require 'spec_helper'

describe Claim do
  before { @claim = Claim.new(referral_id: 1) }

  subject { @claim }

  it { should respond_to(:referral_id) }

  describe "when referral_id is not present" do
    before { @claim.referral_id = nil }
    it { should_not be_valid }
  end
end
