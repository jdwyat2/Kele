require "httparty"
require "json"

class Kele
    include httparty

    def initialize(email, password)
        response = self.class.post(api_url("sessions"), body: {"email": email, "password": password })
        
        raise InvalidStudentCodeError.new() if response.code == 401
        @auth_token = response["auth_token"]
    end
    
    def api_url(endpoint)
        "https://www.bloc.io/api/v1/#{endpoint}"
    end
    
    def get_me
        response = self.class.get(api_url('users/me'), headers: { "authorization" => @auth_token })
        @user = JSON.parse(response.body)
    end
end

# GET https://www.bloc.io/api/v1/users/me