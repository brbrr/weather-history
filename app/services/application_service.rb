# frozen_string_literal: true
class ApplicationService
  attr_reader :user, :errors

  def self.call(*arguments)
    new(*arguments).tap(&:perform)
  end

  def perform
    ActiveRecord::Base.transaction do
      return true if executing

      errors[:service] << 'unknown error' if errors.empty?
      raise ActiveRecord::Rollback
    end

    failure_callback
    # some logging could be here
    false
  end

  def success?
    @errors.empty?
  end

  private

  def initialize(*_arguments)
    @errors = ServiceErrors.new
  end

  def executing
    raise 'not implemented'
  end

  def failure_callback
  end
end
