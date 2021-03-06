class Api::V1::S3TokenController < ApplicationController
  
  def default_max_size
    return 1 #1 MB
  end
  
  def photo_max_size
    return 10 #10 MB
  end
  
  def video_max_size
    return 20 #20 MB
  end
  
  def index
    params.require(:ftype)
    render json: {
      policy:    s3_upload_policy,
      signature: s3_upload_signature,
      key:       ENV['AWS_KEY']
    }
  end

  protected

  def s3_upload_policy
    if params[:ftype] == 'video'
      @policy ||= create_s3_upload_policy(self.video_max_size)
    elsif params[:ftype] == 'photo'
      @policy ||= create_s3_upload_policy(self.photo_max_size)
    else
      @policy ||= create_s3_upload_policy(self.default_max_size)
    end
  end

  def create_s3_upload_policy(max_size)
    Base64.encode64(
      {
        "expiration" => 1.hour.from_now.utc.xmlschema,
        "conditions" => [ 
          { "bucket" =>  ENV['AWS_BUCKET'] },
          [ "starts-with", "$key", "" ],
          { "acl" => "public-read" },
          [ "starts-with", "$Content-Type", "" ],
          [ "content-length-range", 0, max_size * 1024 * 1024 ]
        ]
      }.to_json).gsub(/\n/,'')
  end

  def s3_upload_signature
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), ENV['AWS_SECRET'], s3_upload_policy)).gsub("\n","")
  end
  
end