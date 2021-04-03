class User < ActiveRecord::Base
  has_secure_password
  has_many :notes

  def fullname
    "#{self.first_name} #{self.last_name}"
  end
  
  def recent_notes
    self.notes.max(3) {|note_a, note_b| note_a.completion_date <=> note_b.completion_date}
  end

  def most_difficult
    self.notes.max {|note_a, note_b| note_a.difficulty <=> note_b.difficulty}
  end

  def most_satisfying
    self.notes.max {|note_a, note_b| note_a.satisfaction_rating <=> note_b.satisfaction_rating}
  end

  def greatest_note
    self.notes.max {|note_a, note_b| note_a.composite_index <=> note_b.composite_index}
  end




end
