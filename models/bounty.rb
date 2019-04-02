require('pg')

class Bounty

  def initialize(details)
    @name = details['name']
    @species = details['species']
    @bounty_value = details['bounty_value'].to_i
    @cashed_in = details['cashed_in']
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
    "
    values = [@name, @species, @bounty_value, @cashed_in]
    db.prepare("save", sql)
    db.exec_prepared("save", values)
    db.close()
  end

  def update()

  end


end
