require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  context "validations" do
    should_validate_presence_of :name
    should_validate_presence_of :estimate
    should_validate_numericality_of :estimate
    should_validate_numericality_of :completedin

    should "require stop time after start time" do
      start = 1.minute.ago
      stop = 10.minutes.ago
      assert (stop < start), "sanity check: we're testing that stop is before start"
      c = Challenge.new(:name => 'new', :started_at => start, :stopped_at => stop)
      assert !c.valid?, "our c should *not* be valid!!!" 
      assert c.errors[:stopped_at].present?, "should have the error on stop-time, but had it on: #{c.errors.full_messages.inspect}"
    end
  end
end
