class Challenge < ActiveRecord::Base
  belongs_to :user

  named_scope :unassigned, :conditions => {:user_id => nil}

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
  def started?
    self.started_at.present?
  end
  def stopped?
    self.stopped_at.present?
  end
  def aborted?
    self.aborted_at.present?
  end

  def done?
    started? && (stopped? || aborted?)
  end


  #######
  # Scoring-related helpers
  def estimated_stop_date
    (started_at || Time.now) + (estimate || 0).seconds
  end

  
  def status
    return "Aborted" if aborted?
    return "Completed" if done?
    return "Started" if started?
    "New"
  end
end
