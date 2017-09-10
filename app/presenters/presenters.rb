module Presenters

  def present(data:, presenter: nil, locals: {})
    presenter = presenter || get_presenter_class(data)
    view_context = self.kind_of?(ActionController::Base) ? self.view_context : self
    presenter.present(data, view_context, locals)
  end

  private

  def get_presenter_class(model)
    "#{get_class(model).name.pluralize.underscore}_presenter".classify.constantize
  end

  def get_class(model)
    return model.klass if model.is_a?(ActiveRecord::Relation)
    return model.first.class if model.respond_to? :each
    model.class
  end

  module BasePresenter
    def self.included(mod)
      mod.extend ClassMethods
    end

    module ClassMethods
      def present(data_object, view, locals={})
        klass = collection?(data_object) ? :Enum : :Scalar
        const_get(klass).new(data_object, view, locals)
      end

      private

      def collection?(object)
        [Array, ActiveRecord::Relation].any? {|klass| object.is_a?(klass)}
      end
    end
  end


  class ScalarPresenter < SimpleDelegator
    def initialize(object, view, locals={})
      @view = view
      @locals = locals
      create_instance_variables(locals)
      super(object)
    end

    def data_object
      __getobj__
    end

    def h
      @view
    end

    private

    def create_instance_variables(locals)
      locals.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end
  end

  class EnumPresenter < ScalarPresenter
    include Enumerable

    def each
      data_object.each do |object|
        yield self.class.parent.present(object, h, @locals)
      end
    end

  end
end


