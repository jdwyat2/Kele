require "httparty"

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
end