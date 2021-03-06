require File.expand_path(File.dirname(__FILE__) + '/helper')

describe "AutoReload" do

  it "should autoreload" do
    # create a library
    library = Pathname.new('tmp/library.rb')
    library.write 'def foo; 1; end'

    # setup the autoreload
    autoreload(:interval => 1) do #, :verbose=>true)
      require "library"
    end

    # check the number
    foo.must_equal 1

    # wait is needed for time stamp to not be same with the next file.
    sleep 2

    # recreate the file
    library.write 'def foo; 2; end'

    # wait again for the autoreload loop to repeat.
    sleep 2

    # check the number again
    foo.must_equal 2

    # clean up
    library.delete
  end

end
