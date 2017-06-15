
class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end


  def self.create_table
    sql =  <<-SQL
        CREATE TABLE students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade INTEGER
          )
          SQL
      DB[:conn].execute(sql)
  end

  def save
     sql = <<-SQL
       INSERT INTO students (name, grade)
       VALUES (?, ?)
     SQL
     DB[:conn].execute(sql, self.name, self.grade)

     @id = DB[:conn].execute("SELECT id FROM students WHERE name = ?", self.name).flatten.first
   end

   def self.drop_table
     sql = DB[:conn].execute("DROP TABLE students")
   end

   def self.create(name:, grade:)
     new_student = Student.new(name, grade)
     new_student.save
     new_student
   end



end
