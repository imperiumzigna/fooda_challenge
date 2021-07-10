def load_json(filename)
  File.read(File.join('spec', 'fixtures', filename))
end
