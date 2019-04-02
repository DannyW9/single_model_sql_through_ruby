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

end
