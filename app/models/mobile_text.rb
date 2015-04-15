class MobileText
  include Mongoid::Document
  include Mongoid::Timestamps
  host = ''
  field :username, type: String
  field :scode, type: String
  field :mobile, type: String
  field :content, type: String
  field :extcode, type: String
  field :sendtime, type: String
  field :msgid, type: String
  field :msgtype, type: String
  field :signtag, type: String
  field :temid, type: String

  def post(url, params)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == 'https'
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.use_ssl = true
      end
        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'application/json;charset=utf-8'
        request['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1; rv:29.0) Gecko/20100101 Firefox/29.0'
        request['X-ACL-TOKEN'] = 'xxx_token'
        #request.set_form_data(params)
        request.body = params.to_json
        response = http.start { |http| http.request(request) }
        response.body.to_json
  end

end
