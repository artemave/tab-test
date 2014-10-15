require 'uuid'

class NoteID
  def self.generate
    uuid = UUID.new
    uuid.generate
  end
end
