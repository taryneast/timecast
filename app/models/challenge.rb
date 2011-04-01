class Challenge < ActiveRecord::Base

  ############
  # validations
  validates_presence_of :name
  validates_presence_of :estimate

  validates_numericality_of :estimate, :greater_than_or_equal_to => 0, :allow_nil => true, :only_integer => true
  validates_numericality_of :completedin, :greater_than_or_equal_to => 0, :allow_nil => true, :only_integer => true

  validate :start_before_stop


  ############
  # validation helpers
  
  def start_before_stop
    return if started_at.blank? || stopped_at.blank?
    errors.add :stopped_at, "must be after started-at!" if started_at >= stopped_at
  end


end
