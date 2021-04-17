module RequestHelpers
  def serialize(obj, serializer_class = nil, options = {})
    serializer_class ||= "#{obj.class.name}Serializer".safe_constantize
    json(serializer_class.new(obj, options).to_json)
  end

  def serialize_all(collection, serializer_class = nil)
    collection = [collection].flatten
    serializer_class ||= "#{collection.first.class.name}Serializer".safe_constantize

    serialized_content = ActiveModelSerializers::SerializableResource.new(
      collection,
      each_serializer: serializer_class
    ).to_json

    json(serialized_content)
  end

  def json(value = response.body)
    JSON.parse(value, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include RequestHelpers, type: :request
end
