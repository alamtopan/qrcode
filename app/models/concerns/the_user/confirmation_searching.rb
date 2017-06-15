module TheUser
  module ConfirmationSearching
    extend ActiveSupport::Concern

    module ClassMethods
      def by_keywords(_key)
        return if _key.blank?
        query_opts = [
          "LOWER(confirmations.invoice_code) LIKE LOWER(:key)",
          "LOWER(confirmations.sender_name) LIKE LOWER(:key)"
        ].join(' OR ')
        where(query_opts, {key: "%#{_key}%"} )
      end

      def search_by(options={})
        results = latest

        if options[:key].present?
          results = results.by_keywords(options[:key])
        end

        return results
      end
    end

  end
end
