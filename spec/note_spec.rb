require 'spec_helper'

describe Note do
  let(:opts) do
    {'title' => 'buy a phone', 'text' => 'maybe on amazon', 'password' => 'secret'}
  end

  describe '.create' do
    it 'generates unique id' do
      allow(NoteID).to receive(:generate).and_return('note_id')
      note = Note.create(opts)
      expect(note.id).to eq 'note_id'
    end
  end
end
