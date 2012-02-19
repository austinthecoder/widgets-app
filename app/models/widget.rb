class Widget
  extend ActiveModel::Naming

  include ActiveModel::Conversion
  include Modelable

  class << self
    def active
      where :active => true
    end

    def where(*args)
      query { where *args }
    end

    def query(&block)
      record_class.instance_eval(&block).all.map { |w| new w }
    end
  end

  delegate :title, :description, :active?, :active, :to => :record

  def errors
    [].tap do |errors|
      errors << "Title can't be blank" if title.blank?
    end
  end

end