require 'spec_helper'

describe Claim do
  before { @claim = Claim.new(referral_id: 1) }

  subject { @claim }

  it { should respond_to(:referral_id) }
end
