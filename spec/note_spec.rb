require 'spec_helper'

describe Note do
  let(:opts) do
    {'title' => 'buy a phone', 'text' => 'maybe on amazon', 'password' => 'secret'}
  end

  let(:note_id_class) { class_double('NoteID').as_stubbed_const }

  describe '.create' do
    it 'generates unique id' do
      allow(note_id_class).to receive(:generate).and_return('note_id')
      note = Note.create(opts)
      expect(note.id).to eq 'note_id'
    end

    it 'stores note to fs' do
      note_storage_class = class_spy('NoteStorage').as_stubbed_const
      note = Note.create(opts)
      expect(note_storage_class).to have_received(:store).with(name: note.id, content: note.to_json)
    end
  end
end
