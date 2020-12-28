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
    print_student_list
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

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_process(choice)
  case choice
  when "1"
    simple_print
  when "2"
    alphabetically
  when "3"
    print_cohort
  else
    puts "I don't know what you mean, please try again"
  end
end

def simple_print
  print_header
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
  print_footer
end

def alphabetically
  alphabetical = []
  (@students.length).times{alphabetical.push([])}
  count = 0
  while count < (@students.length - 1)
    @students.each do |student|
      alphabetical[count].push(student[:name])
      alphabetical[count].push(student[:cohort])
      count += 1
    end
  end
  in_order = alphabetical.sort
  puts "The students in alphabetical order are : "
  in_order.each{|arr| puts "#{arr[0]}, #{arr[1]} cohort"}
end

def print_cohort
  sort_by_cohort = {}
  @students.each do |student|
    cohort = student[:cohort]
    name = student[:name]
    if sort_by_cohort[cohort] == nil
      sort_by_cohort[cohort] = [name]
    else
      sort_by_cohort[cohort].push(name)
    end
  end
    puts "The cohorts available are : #{sort_by_cohort.keys}"
    cohort_choice = STDIN.gets.chomp.capitalize.to_sym
    if sort_by_cohort.include?(cohort_choice)
      puts sort_by_cohort[cohort_choice]
    else
      puts "Choose from existing cohorts #{sort_by_cohort.keys}"
    end
end

def print_student_list
  puts "Would you like to:
        1. See all students
        2. See all students in alphabetical order
        3. See a specific cohort"
  print_process(STDIN.gets.chomp)
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
    File::open("students.csv", "w") do |file|
      @students.each do |student|
        student_data = [student[:name], student[:cohort]]
        csv_line = student_data.join(",")
        file.puts csv_line
      end
    end
  elsif filename.split(".")[1] == "csv"
  File::open(filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
  else
    puts "The file will be saved as 'csv'.\nPlease enter a filename with or without the '.csv' extension."
  end
  puts "The list of students have been saved on #{filename}."
end

def load_students(filename = "students.csv")
    puts "Which file would you like to see?\nThe csv files are: "
    Dir.foreach("./") {|file| puts "#{file}" if file=~/.csv/}
    filename = STDIN.gets.chomp

    if filename.nil? || !File.exists?(filename)
      puts "Please choose from the given ones and don't forget to put the .csv extension."
      filename = STDIN.gets.chomp
    end

    File::open(filename, "r") do |file|
      file.readlines.each do |line|
        name, cohort = line.chomp.split(',')
        if @students.empty?
          @students << {name: name, cohort: cohort.to_sym}
        else
          @students
        end
      end
    end
  print_student_list
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
