require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'
require 'csv'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Google Sheets API: access GrayDB of CfEJ'
CLIENT_SECRETS_PATH = 'client_secret.json'
##CREDENTIALS_PATH = File.join(Dir.home, '.credentials', "sheets.googleapis.cfej-import-wikidata.yaml")
CREDENTIALS_PATH = "sheets.googleapis.cfej-import-wikidata.yaml"
SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  ##FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  if !File.exist?(CLIENT_SECRETS_PATH)
    puts "Error: OAuth2認証用のsecretファイルが見つかりませんでした"
    puts "以下のURLからこのプロジェクト用のsecretを作成し、'client_secret.json'というファイル名でこのディレクトリに保存してください。"
    puts
    puts "https://console.developers.google.com/start/api?id=sheets.googleapis.com"
    exit 1
  end

  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts "以下のURLにWebブラウザでアクセスし、認証を行った後、表示されるコードを入力してください:"
    puts url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: OOB_URI)
  end
  credentials
end

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
