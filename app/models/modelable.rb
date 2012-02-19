module Modelable
  extend ActiveSupport::Concern

  included do
    delegate :created_at, :updated_at, :persisted?, :attributes, :destroy, :to => :record

    private_class_method :new
  end

  module ClassMethods
    def build(attrs = {})
      new record_class.new(attrs)
    end

    def find(id)
      new record_class.find(id)
    end

  private
    def table_name(table_name = nil)
      if table_name
        @table_name = table_name
      else
        @table_name ||= self.to_s.downcase.pluralize
      end
    end

    def record_class(record_class = nil)
      if record_class
        @record_class = record_class
      else
        @record_class ||= Class.new(ActiveRecord::Base).tap do |klass|
          klass.set_table_name table_name
        end
      end
    end
  end

  def initialize(record)
    @record = record
  end

  def id
    record.try :id
  end

  def destroy!
    record.destroy
  end

  def save(attrs = {})
    record.attributes = attrs
    errors.empty? && begin
      record.save!
      self
    end
  end

  def errors
    []
  end

private

  attr_reader :record

end