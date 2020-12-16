def input_students
  months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
  puts "Please enter the names of the student and the cohort they are in separated by a comma".center(50)
  puts "To finish, just hit return twice".center(50)

  students = []
  name_cohort = STDIN.gets.delete("\n")

  while !name_cohort.empty? do
    name, cohort = name_cohort.split(", ")
    if cohort != nil && months.include?(cohort.to_sym.capitalize)
      students << {name: name, cohort: cohort.to_sym.capitalize}
    elsif cohort != nil && !months.include?(cohort.to_sym.capitalize)
      puts "Please enter a valid cohort".center(50)
    elsif cohort == nil
      students << {name: name, cohort: :November}
    end

    if students.count == 1
      puts "Now we have #{students.count} student".center(50)
    else
      puts "Now we have #{students.count} students".center(50)
    end
    name_cohort = STDIN.gets.delete("\n")
  end
  students
end

def print_header
  puts "The cohorts of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(names)
  sort_by_cohort = {}
  names.each do |name|
    cohort = name[:cohort]
    name = name[:name]
    if sort_by_cohort[cohort] == nil
      sort_by_cohort[cohort] = [name]
    else
      sort_by_cohort[cohort].push(name)
    end
  end

  puts sort_by_cohort.keys

  puts "Which cohort would you like to see?"
  answer = STDIN.gets.delete("\n").to_sym.capitalize

  if sort_by_cohort.include?(answer)
    puts sort_by_cohort[answer]
  else
    puts "Choose from existing cohorts #{sort_by_cohort[cohort]}"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(50)
end

# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
