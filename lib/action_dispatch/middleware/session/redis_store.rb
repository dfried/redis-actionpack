require 'redis-store'
require 'redis-rack'
require 'action_dispatch/middleware/session/abstract_store'

module ActionDispatch
  module Session
    class RedisStore < Rack::Session::Redis
      include Compatibility
      include StaleSessionCheck
      include SessionObject

      def initialize(app, options = {})
        options = options.dup
        options[:redis_server] ||= options[:servers]
        super
      end

      private
      #This is from https://github.com/redis-store/redis-actionpack/pull/2/files

      def set_cookie(env, session_id, cookie)
        request = ActionDispatch::Request.new(env)
        request.cookie_jar[key] = cookie
    end
  end
end
