module TheUser
  module TeacherSearching
    extend ActiveSupport::Concern

    module ClassMethods
      def by_keywords(_key)
        return if _key.blank?
        query_opts = [
          "LOWER(profile_teachers.nik) LIKE LOWER(:key)",
          "LOWER(users.username) LIKE LOWER(:key)",
          "LOWER(users.email) LIKE LOWER(:key)"
        ].join(' OR ')
        where(query_opts, {key: "%#{_key}%"} )
      end

      def search_by(options={})
        results = bonds

        if options[:key].present?
          results = results.by_keywords(options[:key])
        end

        return results
      end
    end

  end
end
