module HashidsRails
  # based on obfuscate_id by namick
  # ref: https://github.com/namick/obfuscate_id
  def hash_id(options = {})
    require 'hashids'
    extend ClassMethods
    include InstanceMethods
    cattr_accessor :hash_salt
    self.hash_salt = (options[:salt] || default_salt)
  end

  def self.hide(id, salt)
    hashids = Hashids.new(salt, 3)
    hashids.enncode id
  end

  def self.show(id, salt)
    hashids = Hashids.new(salt, 3)
    hashids.decode id
  end

  module ClassMethods
    def find(*args)
      scope = args.slice!(0)
      options = args.slice!(0) || {}
      if has_hashed_id? && !options[:no_hashed_id]
        if scope.is_a?(Array)
          scope.map! {|a| dehash_id(a).to_i}
        else
          scope = dehash_id(scope)
        end
      end
      super(scope)
    end

    def has_hashed_id?
      true
    end

    def dehash_id(hashed_id)
      HashidsRails.show(hashed_id, self.hash_salt)
    end

    # Generate a default salt from the Model name
    # This makes it easy to drop hashids onto any model
    # and produce different hashes for different models
    def default_salt
      name
    end
  end

  module InstanceMethods
    def to_param
      HashidsRails.hide(self.id, self.class.hash_salt)
    end

    # Override ActiveRecord::Persistence#reload
    # passing in an options flag with { no_hashed_id: true }
    def reload(options = nil)
      options = (options || {}).merge(no_hashed_id: true)

      clear_aggregation_cache
      clear_association_cache

      fresh_object =
        if options && options[:lock]
          self.class.unscoped { self.class.lock(options[:lock]).find(id, options) }
        else
          self.class.unscoped { self.class.find(id, options) }
        end

      @attributes = fresh_object.instance_variable_get('@attributes')
      @new_record = false
      self
    end

    def dehash_id(hashed_id)
      self.class.dehash_id(hashed_id)
    end
  end
end

ActiveRecord::Base.extend HashidsRails
