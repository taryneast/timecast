class Challenge < ActiveRecord::Base
  belongs_to :user

  named_scope :unassigned, :conditions => {:user_id => nil}

  before_validation :set_now_dates_to_time_now

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


  ############
  # date helpers
  def set_now_dates_to_time_now
    self.aborted_at = Time.now if self.aborted_at.present? && self.aborted_at == 'now'
    self.started_at = Time.now if self.started_at.present? && self.started_at == 'now'
    self.stopped_at = Time.now if self.stopped_at.present? && self.stopped_at == 'now'
  end

end
