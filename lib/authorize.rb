OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Google Sheets API: access GrayDB of CfEJ'
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

