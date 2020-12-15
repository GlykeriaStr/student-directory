def input_students
  puts "Please enter the names of the students".center(50)
  puts "To finish, just hit return twice".center(50)

#create an empty array
  students = []

# get the first name
  name = gets.chomp

# while the name is not empty repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name}
    puts "Now we have #{students.count} students".center(50)
    # get another name from the user
    name = gets.chomp
  end

  # return the array of students
  students
  input_country(students)
end

def input_country(students)
  puts "Please enter the country of birth of the student".center(50)
  puts "To finish, just hit return twice".center(50)
  country = gets.chomp
  while !country.empty? do
    n = 0
    while n < students.count do
      students[n][:country] = country
      puts "#{students[n][:name]}'s country of birth is #{country}".center(50)
      n += 1
      country = gets.chomp
    end
  end
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  students.each do |name|
    puts "#{name[:name]}, #{name[:cohort]} cohort, #{name[:country]}".center(20)
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(20)
end

# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
