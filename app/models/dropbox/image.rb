module Dropbox
  class Image
    # This class allows us to create a wallpaper from a StringIO
    class FilelessIO < StringIO
      attr_accessor :original_filename

      def initialize(string, original_filename)
        @original_filename = original_filename
        super(string)
      end
    end

    attr_accessor :image_string

    def initialize(image_string, path)
      @image_string = image_string
      @path = path
    end

    def data
      @data = FilelessIO.new(image_string, original_filename)
    end

    def original_filename
      Pathname.new(@path).basename.to_s
    end

    def unique_hash
      Digest::SHA1.hexdigest(image_string)
    end

    def dimensions
      FastImage.new(data).size
    end

    def width
      dimensions.try(:first)
    end

    def height
      dimensions.try(:second)
    end

    def to_hash
      { :width => width,
        :height => height,
        :unique_hash => unique_hash,
        :file => data,
        :bytes => data.size }
    end
  end
end