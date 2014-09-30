module Hopo
  class Error < Exception
  end
  class AuthenticationError < Error
  end
  class ParameterError < Error
  end
end
