# frozen_string_literal: true

module DomainComAuServices
  module V1
    module ApiExceptions
      ApiExceptionError            = Class.new(StandardError)
      BadEnvironnementError        = Class.new(ApiExceptionError)
      BadRequestError              = Class.new(ApiExceptionError)
      UnauthorizedError            = Class.new(ApiExceptionError)
      ForbiddenError               = Class.new(ApiExceptionError)
      ApiRequestsQuotaReachedError = Class.new(ApiExceptionError)
      PageNotFoundError            = Class.new(ApiExceptionError)
      UnprocessableEntityError     = Class.new(ApiExceptionError)
      NoRefreshToken               = Class.new(ApiExceptionError)
      ApiError                     = Class.new(ApiExceptionError)
    end
  end
end
