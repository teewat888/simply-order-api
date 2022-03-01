Rails.configuration.to_prepare do
    class TPError < StandardError 

    end

    class TPAuthError < StandardError

    end
end