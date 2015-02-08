module ActiveAdmin
  module Axlsx
    module DataAccessExtension
      def self.included(base)
        base.send :alias_method_chain, :find_collection, :xlsx
      end

      def find_collection_with_xlsx
        collection = scoped_collection

        collection = apply_authorization_scope(collection)
        collection = apply_sorting(collection)
        collection = apply_filtering(collection)
        collection = apply_scoping(collection)

        unless [ 'text/csv', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'].include? request.format
          collection = apply_pagination(collection)
        end

        collection = apply_collection_decorator(collection)

        collection
      end
    end
  end
end
