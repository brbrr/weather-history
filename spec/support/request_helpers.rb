module Requests
  module JsonHelpers
    attr_reader :response

    def json
      JSON.parse(response.body)
    end

    def method_missing(method, *args)
      return unless method =~ /_helper$/

      raise "#{method} expects a valid argument, '#{args.first}' passed" if args.first.blank?
      raise "#{args.first.class} is not persisted" if args.first.try(:id).blank?

      method.to_s.gsub(/_helper$/, 'Serializer').classify.constantize.new(args.first, root: nil).attributes.as_json
    end
  end

  module AuthenticationHelpers
    def get_as_user(url, params: {}, headers: _user_auth_headers)
      get(url, params: params, headers: headers)
    end

    [:post, :put, :delete, :patch].each do |m|
      define_method "#{m}_as_user" do |url, opts = {}|
        opts = {} if opts.blank?
        opts = opts.to_json unless opts.values.any? { |v| v.class == Rack::Test::UploadedFile }

        send(m, url, opts, _user_auth_headers)
      end
    end

    def register(email, password, confirmation: password)
      params = {
        user: {
          email: email,
          password: password,
          password_confirmation: confirmation
        }
      }
      post('/users.json', params: params.to_json, headers: _auth_headers)
    end

    def sign_in(email, password)
      params = {
        user: {
          email: email,
          password: password,
          password_confirmation: confirmation
        }
      }
      post('/users/sign_in.json', params: params.to_json, headers: _auth_headers)
    end

    def authenticate(email, password)
      params = {
        grant_type: 'password',
        username: email,
        password: password
      }
      post('/oauth/token', params: params.to_json, headers: _auth_headers)
      @_access_token = Oj.load(response.body)[:access_token]
    end

    private

    def _auth_headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) ' \
          'Chrome/19.0.1084.56 Safari/536.5',
        'X-API-Version' => '0.0.1',
        'X-API-Client' => 'ExampleApp/TestSuite 0.0.1',
        'X-API-Device' => 'iPhone 5,1 (iOS 8.1.3)'
      }
    end

    def _user_auth_headers(access_token = _access_token)
      @_access_token ||= access_token
      _auth_headers.merge('Authorization' => "Bearer #{@_access_token}")
    end

    def _user
      raise '"user" variable in request tests is not defined' unless respond_to?(:user) || user.present?
      user
    end

    def _access_token
      @_access_token ||= create(:access_token, application: _client_application, resource_owner_id: _user.id).token
    end

    def _client_application
      @_client_application ||= try(:client_application) || create(:client_application)
    end
  end
end
