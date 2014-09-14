module BitFlags
  extend ActiveSupport::Concern

  included do
  end
  
  module ClassMethods
    def bit_flags column, map
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def self.#{column}_map symbol
        #{map.invert}[symbol]
      end
      
      scope :#{column}_include, -> (*args) {
        f = 0
        args.each do |s|
          f |= 1 << (#{column}_map s)
        end
        where("#{column} & \#{f} > \#{f}")
      }
      
      scope :#{column}_exclude, -> (*args) {
        f = 0
        args.each do |s|
          f |= 1 << (#{column}_map s)
        end
        where("#{column} & \#{f} = 0")
      }
      
      RUBY_EVAL
      
      map.each do |offset, label|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        
        scope :#{label}?, -> (disabled) {
          express = disabled ? '#{column} & #{1 << offset} > 0' : '#{column} & #{1 << offset} = 0'
          where(express)
        }
        
        def #{label}
          self.#{column} = 0 unless self.#{column}.kind_of?(Integer)
          (self.#{column} & #{1 << offset}) > 0
        end
        
        def #{label}=(value)
          self.#{column} = 0 unless self.#{column}.kind_of?(Integer)
          if value
            self.#{column} |= #{1 << offset}
          else
            self.#{column} = (self.#{column} | #{1 << offset}) ^ #{1 << offset}
          end
        end
        RUBY_EVAL
      end
    end
  end
end
