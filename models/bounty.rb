require('pg')

class Bounty

  attr_accessor :name, :species, :bounty_value, :cashed_in
  attr_reader :id

  def initialize(details)
    @name = details['name']
    @species = details['species']
    @bounty_value = details['bounty_value'].to_i
    @cashed_in = details['cashed_in']
    @id = details['id'].to_i if details['id']
  end

  def save()
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost'})
    sql = "INSERT INTO bounties
    (
      name,
      species,
      bounty_value,
      cashed_in
    )
    VALUES ($1, $2, $3, $4)
    RETURNING id
    "
    values = [@name, @species, @bounty_value, @cashed_in]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def update()
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost'})

    sql = "UPDATE bounties
    SET (
      name,
      species,
      bounty_value,
      cashed_in
    ) =
    ( $1, $2, $3, $4 )
    WHERE id = $5"
    values = [@name, @species, @bounty_value, @cashed_in, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Bounty.delete_all()
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost'})
    sql = "DELETE FROM bounties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  #################### EXTENSIONS ######################

  def Bounty.find_by_name(search)
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1"
    values = [search]
    db.prepare("find_by_name", sql)
    result = db.exec_prepared("find_by_name", values)
    db.close()
    if result == []
      return nil
    else
      return Bounty.new(result[0])
    end
    #.map { |bounty| Bounty.new(bounty) }
    # Could not get the actual details without Map
    # #<PG::Result:0x007feca8346ec0 status=PGRES_TUPLES_OK ntuples=2 nfields=5 cmd_tuples=2>
  end

  def Bounty.find_by_id(id)
      db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost'})
      sql = "SELECT * FROM bounties WHERE id = $1"
      values = [id]
      db.prepare("find_by_id", sql)
      result = db.exec_prepared("find_by_id", values)
      db.close()
      return Bounty.new(result[0])#.map { |bounty| Bounty.new(bounty) }
    end

end
