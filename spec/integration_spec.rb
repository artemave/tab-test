require 'spec_helper'

describe "The whole thing for real" do
  let(:opts) do
    {'title' => 'buy a phone', 'text' => 'maybe on amazon', 'password' => 'secret'}
  end

  it 'fetches previously created note' do
    post '/notes', opts
    expect(last_response).to be_ok

    created_note = JSON.parse last_response.body

    get "/notes/#{created_note['id']}?password=#{opts['password']}"
    expect(last_response).to be_ok

    fetched_note = JSON.parse last_response.body

    expect(fetched_note['id']).to eq created_note['id']
    expect(fetched_note['title']).to eq opts['title']
    expect(fetched_note['text']).to eq opts['text']
  end
end
