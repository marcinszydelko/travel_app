require_relative( '../db/sql_runner' )

class Country

  attr_reader :id
  attr_accessor :name, :visited

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @visited = options['visited']
  end

  def save()
    sql = "INSERT INTO countries
    (
      name,
      visited
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @visited]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE countries SET (name, visited) = ($1, $2) WHERE id = $3"
    values = [@name, @visited, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM countries WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end

  def self.show_cities_visited(id)
    sql = "SELECT cities.* FROM cities JOIN countries ON countries.id = cities.country_id WHERE countries.id = $1"
    cities  = SqlRunner.run(sql, [id])
    return cities.map{ |city|
      if city['visited'].to_s == "t"
      City.new(city)
      end
    }.compact
  end

  def self.show_cities_unvisited(id)
    sql = "SELECT cities.* FROM cities JOIN countries ON countries.id = cities.country_id WHERE countries.id = $1"
    cities  = SqlRunner.run(sql, [id])
    return cities.map{ |city|
      if city['visited'].to_s == "f"
      City.new(city)
      end
    }.compact
  end

  def self.visited()
    sql = "SELECT * FROM countries WHERE visited = $1"
    results = SqlRunner.run(sql,["true"])
    return results.map { |country| Country.new(country) }
  end

  def self.unvisited()
    sql = "SELECT * FROM countries WHERE visited = $1"
    results = SqlRunner.run(sql,["false"])
    return results.map { |country| Country.new(country) }
  end

  def self.all()
    sql = "SELECT * FROM countries"
    results = SqlRunner.run(sql)
    return results.map { |country| Country.new(country) }
  end

  def self.find(id)
    sql = "SELECT * FROM countries WHERE id = $1"
    results = SqlRunner.run(sql, [id])
    return Country.new(results.first)
  end

  def self.delete_all()
    sql = "DELETE FROM countries"
    SqlRunner.run(sql)
  end

end
