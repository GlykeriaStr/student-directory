@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list of students"
  puts "4. Load the list of students"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def input_students
  months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
  puts "Please enter the names of the student and the cohort they are in separated by a comma".center(50)
  puts "To finish, just hit return twice".center(50)

  name_cohort = STDIN.gets.delete("\n")

  while !name_cohort.empty? do
    name, cohort = name_cohort.split(", ")
    if cohort != nil && months.include?(cohort.to_sym.capitalize)
      @students << {name: name, cohort: cohort.to_sym.capitalize}
    elsif cohort != nil && !months.include?(cohort.to_sym.capitalize)
      puts "Please enter a valid cohort".center(50)
    elsif cohort == nil
      @students << {name: name, cohort: :November}
    end

    if @students.count == 1
      puts "Now we have #{@students.count} student".center(50)
    else
      puts "Now we have #{@students.count} students".center(50)
    end
    name_cohort = STDIN.gets.delete("\n")
  end
  if @students.empty?
    exit
  end
  @students
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  puts "What would you like to name the file?"
  filename = STDIN.gets.chomp
  filename += ".csv" if filename.split(".").length == 1
  filename = "students.csv" if filename.split(".").length == 0

  if filename.split(".")[0] == nil
    file = File.open("students.csv", "w")
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  elsif filename.split(".")[1] == "csv"
  file = File.open(filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  else
    puts "The file will be saved as 'csv'.\nPlease enter a filename with or without the '.csv' extension."
  end
  puts "The list of students have been saved on #{filename}."
  file.close
end

def load_students(filename = "students.csv")

  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
