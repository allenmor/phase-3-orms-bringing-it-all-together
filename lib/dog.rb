require 'pry'

class Dog

    attr_accessor :name, :breed, :id

    def initialize(name:, breed:, id: nil)
        @name = name
        @breed = breed
        @id = id
    end

    def self.create_table
        sql = <<-SQL
        create table if not exists dogs(
            id integer primary key,
            name text,
            breed text
        )
        SQL
        DB[:conn].execute(sql)
    end

    def self.drop_table
        sql = <<-SQL
        drop table dogs
        SQL
        DB[:conn].execute(sql)
    end

    def save 
        sql = <<-SQL
        insert into dogs(name, breed)
        values(?, ?)
        SQL
        DB[:conn].execute(sql, @name, @breed)

        sql2 = <<-SQL
        select max(id) from dogs
        SQL
        self.id = DB[:conn].execute(sql2)[0][0]
        # binding.pry
        
    end

    def self.create(name:, breed:)
        new_dog = Dog.new(name: name, breed: breed)
        new_dog.save
        new_dog
    end

    def self.new_from_db(row)
        Dog.new(id: row[0], name:row[1], breed:row[2])
    end
end


# attr_accessor :name, :breed, :id


# def initialize(name:, breed:, id: nil)
#     @name = name
#     @breed = breed
#     @id = id
# end

# def self.create_table
#     sql = <<-SQL
#     create table if not exists dogs(
#         id integer primary key,
#         name text,
#         breed text
#     )
#     SQL
#     DB[:conn].execute(sql)
# end

# def self.drop_table
#     sql = <<-SQL
#     drop table dogs
#     SQL
#     DB[:conn].execute(sql)
# end

# def save 
#     sql = <<-SQL
#     insert into dogs(name, breed)
#     values(?, ?)
#     SQL
#     sql2 = <<-SQL
#     SELECT MAX(id) FROM dogs
#     SQL
#     DB[:conn].execute(sql, self.name, self.breed)
#     self.id = DB[:conn].execute(sql2)[0][0]
    
#     # binding.pry
#     self
# end

# def self.create(name:, breed:)
#     new_dog = Dog.new(name: name, breed: breed)
#     new_dog.save
# end

# def self.new_from_db(row)
#     # binding.pry
#    self.new(id: row[0], name: row[1], breed:row[2])
   
# end

# def self.all
#     sql = <<-SQL
#     select * from dogs
#     SQL
#     DB[:conn].execute(sql).map{|el| self.new_from_db(el)}
# end

# def self.find_by_name(name)
#     sql = <<-SQL
#     select * from dogs
#     where name = ?
#     limit 1
#     SQL
#     DB[:conn].execute(sql, name).map do 
#         |el| self.new_from_db(el)
#     end.first
    
# end

# def self.find(num)
#     sql = <<-SQL
#     select * from dogs
#     where id = ?
#     SQL
#     yo = DB[:conn].execute(sql, num)[0]
#     Dog.new_from_db(yo)
    
# end
