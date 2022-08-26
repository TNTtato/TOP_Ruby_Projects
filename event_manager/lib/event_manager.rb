require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(phone_number)
  phone_number = phone_number.to_s.gsub(/\D/, '')
  valid_cond = phone_number.length == 10 || (phone_number.length == 1 && phone_number[0] == '1')
  valid_cond ? phone_number[0..9] : 'Not Valid Phone'
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/#{id}_thanks.html"
  File.open(filename, 'w') { |doc| doc.puts form_letter }
end

def get_reg_date(reg_date)
  date_format = "%m/%d/%y %H:%M"
  DateTime.strptime(reg_date, date_format)
end

def get_optimal(count)
  count.tally.max_by { |_k, v| v}
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

registration_hours = []
registration_wdays = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone_number(row[:homephone])
  reg_date = get_reg_date(row[:regdate])
  registration_hours << reg_date.hour
  registration_wdays << reg_date.wday
  legislators = legislators_by_zipcode(zipcode)
  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)
end

optimal_hour_count = get_optimal(registration_hours)
optimal_wday_count = get_optimal(registration_wdays)

puts "The best hour is #{optimal_hour_count[0]}, got #{optimal_hour_count[1]} registrations"
puts "The best day is #{optimal_wday_count[0]}, got #{optimal_wday_count[1]} registrations"
