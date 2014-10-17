# notes service

Create and retreive secure notes.

## install

    $ mkdir notes-service && tar xzf notes-service.tar.gz -C notes-service
    $ cd notes-service && bundle

## run

    $ bundle exec ruby app.rb

### create note

    $ curl --data "title=title;text=text;password=secret" localhost:4567/notes
    {"id":"eb9b2050-3745-0132-5d6b-081fa104c5e2"}

### fetch note

    $ curl "localhost:4567/notes/2231d6b0-369f-0132-5d6a-081fa104c5e2?password=secret"
    {"title":"title","text":"text","id":"2231d6b0-369f-0132-5d6a-081fa104c5e2"}

## run tests

    $ bundle exec rspec
