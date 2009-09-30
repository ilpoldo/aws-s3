require 'test/unit'
require 'uri'
$:.unshift File.dirname(__FILE__) + '/../../lib'
require 'aws/s3'
begin
  require_library_or_gem 'breakpoint'
rescue LoadError
end

TEST_BUCKET = 'ilpoldo-aws-s3-tests'
TEST_FILE   = File.dirname(__FILE__) + '/test_file.data'

class Test::Unit::TestCase
  include AWS::S3
  def establish_real_connection
    Base.establish_connection!( YAML::load(File.open( File.dirname(__FILE__) + "/s3.yml" )) )
  end
  
  def disconnect!
    Base.disconnect
  end
  
  class TestBucket < Bucket
    set_current_bucket_to TEST_BUCKET
  end
  
  class TestS3Object < S3Object
    set_current_bucket_to TEST_BUCKET
  end
end