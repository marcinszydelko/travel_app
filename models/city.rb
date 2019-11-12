require_relative( '../db/sql_runner' )

class City

  attr_reader :id
  attr_accessor :name, :visited, :country_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @visited = options['visited']
    @country_id = options['country_id'].to_i

  end

  def save()
    sql = "INSERT INTO cities
    (
      name,
      visited,
      country_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@name, @visited, @country_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE cities SET (name, visited, country_id) = ($1, $2, $3) WHERE id = $4"
    values = [@name, @visited, @country_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM cities WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end

  # def visited_unvisited()
  #   sql = "SELECT visited FROM cities WHERE id = $1"
  #   result = SqlRunner.run(sql,[@id])
  #   result[0]['visited']
  #
  #   if result[0]['visited'].to_s == "false"
  #     value = false
  #   else
  #     value = true
  #   end
  #
  #   if value == true
  #     sql = "UPDATE cities SET visited = false WHERE id = $1"
  #     SqlRunner.run(sql,[@id])
  #   else
  #     sql = "UPDATE cities SET visited = true WHERE id = $1"
  #     SqlRunner.run(sql,[@id])
  #   end
  # end

  def self.all()
    sql = "SELECT * FROM cities"
    results = SqlRunner.run(sql)
    return results.map { |city| City.new(city) }
  end

  def self.find(id)
    sql = "SELECT * FROM cities WHERE id = $1"
    results = SqlRunner.run(sql, [id])
    return City.new(results.first)
  end

  def self.delete_all()
    sql = "DELETE FROM cities"
    SqlRunner.run(sql)
  end

end
