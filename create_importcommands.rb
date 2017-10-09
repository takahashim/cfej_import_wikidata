require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'
require 'csv'

$LOAD_PATH << "./lib/"
require 'authorize'

# Configuration
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH = "sheets.googleapis.cfej-import-wikidata.yaml"

# Initialize the API
service = Google::Apis::SheetsV4::SheetsService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

spreadsheet_id = '182l2CexnCqZ0GPSg9sp2XMMfvUC4muuvYFdJp2Q-vkI'
range = 'A:AX'

response = service.get_spreadsheet_values(spreadsheet_id, range)
response.values.each do |row|
  next if row[0] != "未登録"

  puts "CREATE"
  print "LAST\tLja\t\"#{row[1]}\"","\n"
end
