require 'active_support/core_ext/string'

module NameOfPerson
  class PersonName < String
    attr_reader :first, :last

    def self.full(full_name)
      first, last = full_name.to_s.squish.split(/\s/, 2)
      new(first, last) if first.present?
    end

    def initialize(first, last = nil)
      raise ArgumentError, "First name is required" unless first.present?
      @first, @last = first, last
      super full
    end

    # Returns first + last, such as "Jason Fried".
    def full
      @full ||= last.present? ? "#{first} #{last}" : first
    end

    # Returns first + last initial, such as "Jason F.".
    def familiar
      @familiar ||= last.present? ? "#{first} #{last.first}." : first
    end

    # Returns first initial + last, such as "J. Fried".
    def abbreviated
      @abbreviated ||= last.present? ? "#{first.first}. #{last}" : first
    end

    # Returns last + first for sorting.
    def sorted
      @sorted ||= last.present? ? "#{last}, #{first}" : first
    end

    # Returns full name with with trailing 's or ' if name ends in s.
    def possessive
      @possessive ||= "#{self}'#{"s" unless end_with?("s")}"
    end

    # Returns just the initials.
    def initials
      @initials ||= remove(/(\(|\[).*(\)|\])/).scan(/([[:word:]])[[:word:]]+/i).join
    end

    # Returns a mentionable version of the familiar name
    def mentionable
      @mentionable ||= familiar.chop.delete(' ').downcase
    end

    # Override to_yaml to serialize as a plain string.
    def encode_with(coder)
      coder.represent_scalar nil, to_s
    end
  end
end
