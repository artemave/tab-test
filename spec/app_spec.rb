require 'spec_helper'

describe 'App' do
  let(:opts) do
    {'title' => 'buy a phone', 'text' => 'maybe on amazon', 'password' => 'secret'}
  end

  let(:note) {
    double('Note', id: 'note_id', password: 'secret', to_json: {
      'title' => opts['title'],
      'text' => opts['text'],
      'id' => 'note_id'
    }.to_json)
  }

  it 'creates a note' do
    allow(Note).to receive(:create).with(opts).and_return(note)

    post '/notes', opts

    expect(last_response).to be_ok

    new_note = JSON.parse last_response.body
    expect(new_note['id']).to eq(note.id)
  end

  it 'returns a note' do
    allow(Note).to receive(:find).with(id: note.id, password: note.password).and_return(note)

    get "/notes/#{note.id}?password=#{note.password}"

    expect(last_response).to be_ok
    expect(last_response.body).to eq(note.to_json)
  end
end
