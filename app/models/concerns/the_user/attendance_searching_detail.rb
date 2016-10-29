module TheUser
  module AttendanceSearchingDetail
    extend ActiveSupport::Concern

    module ClassMethods
      def by_start_at_detail(_start_at)
        return if _start_at.blank?
        where("attendances.created_at >=?", _start_at.to_date)
      end

      def by_end_at_detail(_end_at)
        return if _end_at.blank?
        where("attendances.created_at <=?", _end_at.to_date + 1)
      end

      def search_by_detail(options={})
        results = self

        if options[:start_at].present?
          results = results.by_start_at_detail(options[:start_at])
        end

        if options[:end_at].present?
          results = results.by_end_at_detail(options[:end_at])
        end

        return results
      end
    end

  end
end
