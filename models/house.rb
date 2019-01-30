require_relative('./student.rb')
require_relative('../db/sql_runner.rb')

class House

attr_reader :id
attr_accessor :name, :url

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @url = options['url']
  end

  def save()
    sql = "INSERT INTO houses (name, url) VALUES ($1, $2) RETURNING id"
    values = [@name, @url]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"]
  end

  def update()
    sql = "UPDATE houses SET (name, url) = ($1, $2) WHERE id = $3"
    values = [@name, @url, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM houses"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM houses WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.show_houses()
    sql = "SELECT * FROM houses"
    results = SqlRunner.run(sql)
    houses = results.map{|row| House.new(row)} if results
    return houses
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM houses WHERE id = $1"
    values = [id]
    house_data = SqlRunner.run(sql, values).first
    return House.new(house_data)
  end

end
