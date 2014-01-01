module Cucumber
  module Blanket
    ##
    # Flattens the blanketJS data structure
    module Iron
      def flatten! data
        # go through every line of every file and OR it all together
        # e.g. line 1 is 1 and 0, so it is 1
        #binding.pry
        data
      end
    end
  end
end
