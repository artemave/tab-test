require 'fileutils'

class NoteStorage
  ROOT = './notes/'

  def self.store(name:, content:)
    FileUtils.mkdir_p(ROOT) unless File.exists? ROOT
    File.open(ROOT + name, 'wb') do |f|
      f << content
    end
  end

  def self.fetch fname
    File.binread(ROOT + fname)
  end
end
