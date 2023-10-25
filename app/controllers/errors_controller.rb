# frozen_string_literal: true
class ErrorsController < ApplicationController
  def forbidden
    render status: :forbidden
  end

  def not_found
    render status: :not_found
  end

  def internal_server_error
    render status: :internal_server_error
  end
end
