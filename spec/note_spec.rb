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

    it 'stores encrypted note to fs' do
      note_storage_class = class_spy('NoteStorage').as_stubbed_const

      note = Note.create(opts)
      expected_content = Encryption.encrypt(password: note.password, content: note.to_json)

      expect(note_storage_class).to have_received(:store).with(name: note.id, content: expected_content)
    end
  end

  describe '.find' do
    let(:note_storage_class) { class_double('NoteStorage').as_stubbed_const }
    let(:encryption_class) { class_double('Encryption').as_stubbed_const }

    context "files exists" do
      let(:encrypted_content) { double 'encrypted_content' }
      let(:serialized_note) {
        {id: 'note_id', title: 'cool note', text: 'some text'}.to_json
      }

      before do
        allow(note_storage_class).to receive(:fetch).with('note_id').and_return(encrypted_content)
      end

      context "password is correct" do
        before do
          allow(encryption_class).to receive(:decrypt)
            .with(password: 'secret', encrypted_content: encrypted_content)
            .and_return(serialized_note)
        end

        it 'fetches note from fs' do
          note = Note.find(id: 'note_id', password: 'secret')

          expect(note.id).to eq 'note_id'
          expect(note.title).to eq 'cool note'
          expect(note.text).to eq 'some text'
        end
      end

      context 'password id incorrect' do
        # TODO
      end
    end

    context 'file does not exist' do
      # TODO
    end
  end
end
