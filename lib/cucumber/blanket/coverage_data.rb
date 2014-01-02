module Cucumber
  module Blanket
    ##
    # Contains the blanketJS data structure
    # primary purpose is to accumulate more of this data, flattening
    # the structure against multiple runs of fresh data
    class CoverageData
      attr_reader :data

      def initialize
        @data = {'files'=>{}, 'sources'=>{}}
      end

      def method_missing *args
        @data.send(*args)
      end

      def files
        self.data['files']
      end

      def sources
        self.data['sources']
      end

      def percent_covered script_url
        total_lines = 0
        covered_lines = 0
        self.files[script_url].compact.each do |cov_stat|
          if cov_stat > 0
            covered_lines += 1
          end
          total_lines += 1
        end
        if total_lines > 0
          return ((covered_lines.to_f / total_lines)*100).round(2)
        else
          return 0.0
        end
      end

      def accrue! page_data
        if @data.nil?
          @data = page_data
        else
          # for files in page_data ...
          page_data['files'].each do |filename, linedata|
            # that exist in @data
            if @data['files'][filename]
              # accrue coverage data, meaning:
              # get a handle on existing linedata and iterate
              @data['files'][filename].each_with_index do |cov_stat, line_no|
                new_cov_stat = page_data['files'][filename][line_no]
                # first we need to deal with nils, as we cannot add them
                # either side can be nil -- and we want to be strictly additive
                next if new_cov_stat.nil? # this is not additive, next line
                # So now we know the new data is definitely not nil
                # but the existing data could be, so we'll handle that now
                if cov_stat.nil?
                  @data['files'][filename][line_no] = new_cov_stat
                  # We replaced it with the new data, next line please
                  next
                end
                # if we ever get here, we're dealing strictly with integers
                # as a result we just need to sum the two stats
                @data['files'][filename][line_no] = cov_stat + new_cov_stat
              end
            else # if it does not exist
              # add it to 'files' as is
              @data['files'][filename] = linedata
            end
          end

          # As far as sources are concerned, we just add it if an entry doesn't exist
          page_data['sources'].each do |filename, lines|
            @data['sources'][filename] ||= lines
          end
        end
      end
    end
  end
end
