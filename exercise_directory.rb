def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

#create an empty array
  students = []

# get the first name
  name = gets.chomp

# while the name is not empty repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :November}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end

  # return the array of students
  students
  input_country(students)
end

def input_country(students)
  puts "Please enter the country of birth of the student"
  puts "To finish, just hit return twice"
  country = gets.chomp
  while !country.empty? do
    n = 0
    while n < students.count do
      students[n][:country] = country
      puts "#{students[n][:name]}'s country of birth is #{country}"
      n += 1
      country = gets.chomp
    end
  end
  p students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |name|
    puts "#{name[:name]}, #{name[:cohort]} cohort, #{name[:country]}"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
