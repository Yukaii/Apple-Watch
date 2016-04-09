require 'rack-mini-profiler'

Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemoryStore
Rack::MiniProfilerRails.initialize!(Rails.application)
