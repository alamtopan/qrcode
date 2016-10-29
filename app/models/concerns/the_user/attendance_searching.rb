module TheUser
  module AttendanceSearching
    extend ActiveSupport::Concern

    module ClassMethods
      def by_keywords(_key)
        return if _key.blank?
        query_opts = [
          "LOWER(profile_students.nis) LIKE LOWER(:key)",
          "LOWER(users.username) LIKE LOWER(:key)",
          "LOWER(users.email) LIKE LOWER(:key)"
        ].join(' OR ')
        where(query_opts, {key: "%#{_key}%"} )
      end

      def by_start_at(_start_at)
        return if _start_at.blank?
        where("attendances.created_at >=?", _start_at.to_date)
      end

      def by_end_at(_end_at)
        return if _end_at.blank?
        where("attendances.created_at <=?", _end_at.to_date + 1)
      end

      def search_by(options={})
        results = bonds

        if options[:key].present?
          results = results.by_keywords(options[:key])
        end

        if options[:start_at].present?
          results = results.by_start_at(options[:start_at])
        end

        if options[:end_at].present?
          results = results.by_end_at(options[:end_at])
        end

        return results
      end
    end

  end
end
