require 'active_model'
require_relative 'note_storage'
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
    NoteStorage.store name: note.id, content: note.to_json
    note
  end

  def self.find(id:, password:)
    encrypted_content = NoteStorage.fetch(id)
    content_json = Encryption.decrypt(password: password, encrypted_content: encrypted_content)
    new JSON.load content_json
  end
end
