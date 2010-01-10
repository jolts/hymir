MongoMapper.database = "hymir-#{Rails.env}"
MongoMapper.ensure_indexes!

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect_to_master if forked
  end
end
