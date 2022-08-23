class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  # CREATING A TABLE
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  # INSERTING DATA INTO THE TABLE WITH #save METHOD
  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.album)

    # GIVING Song INSTANCE AN ID
    # get the song ID from the database and save it to the Ruby instance
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

    # return the Ruby instance
    self

  end


  # .create METHOD (This method will wrap the code we used above to create a new Song instance and save it.)
  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end

end

# song.create(name: "Hello", album: "25")
# song.name
# song.album