module Error::Helpers
  class Render
    def self.json(_error, _status, _message)
      {
        success: false,
        status: _status,
        error: _error,
        message: _message
      }.as_json
    end
  end
end