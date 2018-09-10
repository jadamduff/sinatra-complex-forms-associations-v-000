class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  patch '/owners/:id' do
      @owner = Owner.find(params[:id])
      ####### bug fix
      if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
      end
      #######

      @owner.update(params["owner"])
      if !params["pet"]["name"].empty?
        @owner.pets << Pet.create(name: params["pet"]["name"])
      end
      redirect "owners/#{@owner.id}"
  end
end
