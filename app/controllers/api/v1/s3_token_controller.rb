class Api::V1::S3TokenController < ApplicationController
  
  @default_max_size = 1   #1 MB
  @photo_max_size = 10    #10 MB
  @video_max_size = 20    #20 MB

  def index
    params.require(:ftype)
    render json: {
      policy:    s3_upload_policy(params[:ftype]),
      signature: s3_upload_signature,
      key:       ENV['AWS_KEY']
    }
  end

  protected

  def s3_upload_policy(filetype)
    if filetype == 'video'
      @policy ||= create_s3_upload_policy(@video_max_size)
    elsif filetype == 'photo'
      @policy ||= create_s3_upload_policy(@photo_max_size)
    else
      @policy ||= create_s3_upload_policy(@default_max_size)
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