class ServiceErrors
  def errors
    @errors_storage.select { |_k, v| !v.empty? }
  end

  def full_messages
    @errors_storage.map { |k, v| v.map { |msg| "#{k.to_s.humanize} #{msg}" } }.flatten
  end

  def [](attribute)
    attribute = attribute.to_sym
    @errors_storage[attribute] ||= []

    @errors_storage[attribute]
  end

  def []=(attribute, messages)
    attribute = attribute.to_sym
    messages = Array(messages)
    @errors_storage[attribute] = messages
  end

  def empty?
    errors.empty?
  end

  def append_entity_errors(entity, key_name = nil)
    error_group_name = key_name || entity.class.to_s.underscore

    entity.errors.full_messages.each { |e| self[error_group_name] << e.downcase }
  end

  def to_json
    errors.to_json
  end

  def merge!(errors)
    @errors_storage.merge!(errors.errors) if errors.is_a? ServiceErrors
  end

  private

  def initialize
    @errors_storage = {}
  end
end
