require 'active_model'
require_relative 'note_id'

class Note
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  attr_accessor :title, :text, :password, :id

  def attributes # to go into #to_json
    {title: title, text: text, id: id}
  end

  def self.create opts = {}
    note = new opts.merge(id: NoteID.generate)
    note
  end

  def self.find(id:, password:)
    note = new password: password
    note
  end
end
