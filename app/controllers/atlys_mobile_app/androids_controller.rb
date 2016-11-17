require_dependency "atlys_mobile_app/application_controller"

module AtlysMobileApp
  class AndroidsController < ::ApplicationController
    layout "admin"
    before_action :set_android, only: [:show, :edit, :update, :destroy]

    # GET /androids
    def index

    end

    # GET /androids/1
    def show
    end

    # GET /androids/new
    def new
      @android = Android.new
    end

    # GET /androids/1/edit
    def edit
    end

    # POST /androids
    def create

	app_folder = Gem.loaded_specs["atlys_mobile_app"].full_gem_path+"/app/views/atlys_mobile_app/androids/app/."
	temp_folder = Rails.root.to_s+"/tmp/android_app"
	zip_location = Rails.root.to_s+"/public/android_app.zip"

	app_name = "New App Render"
	packge_name = "com.newapp"
	version_code = "1"
	version_name = "1.65"
	domain = "http://mydominanew.com"

	FileUtils.rm_rf(zip_location)

	Dir.mkdir Rails.root.to_s+"/tmp/android_app"

	FileUtils.cp_r app_folder, temp_folder

	# replace string here
	rfile = temp_folder+"/app/src/main/AndroidManifest.xml"
	replace_in_file(rfile, "main.evebusiness", packge_name)

	rfile = temp_folder+"/app/build.gradle"
	replace_in_file(rfile, "main.evebusiness", packge_name)

	rfile = temp_folder+"/app/build.gradle"
	replace_in_file(rfile, "versionCode 4", "versionCode "+version_code)

	rfile = temp_folder+"/app/build.gradle"
	replace_in_file(rfile, "versionName '1.4'", "versionName '"+version_name+"'")

	rfile = temp_folder+"/app/src/main/res/values/strings.xml"
	replace_in_file(rfile, "Eve Business", app_name)

	rfile = temp_folder+"/app/src/main/java/main/evebusiness/FullscreenActivity.java"
	replace_in_file(rfile, "main.evebusiness", packge_name)

	file = temp_folder+"/app/src/main/java/main/evebusiness/util/SystemUiHider.java"
	replace_in_file(rfile, "main.evebusiness", packge_name)

	file = temp_folder+"/app/src/main/java/main/evebusiness/util/SystemUiHiderBase.java"
	replace_in_file(rfile, "main.evebusiness", packge_name)

	file = temp_folder+"/app/src/main/java/main/evebusiness/util/SystemUiHiderHoneycomb.java"
	replace_in_file(rfile, "main.evebusiness", packge_name)

	rfile = temp_folder+"/app/src/main/java/main/evebusiness/FullscreenActivity.java"
	replace_in_file(rfile, "http://eve-business.com", domain)

        zipfolder(temp_folder, zip_location, true)

	send_file zip_location, :type => 'application/zip',
                :disposition => 'attachment',
                :filename => "android_app.zip"

    end




    def zipfolder(dir, zip_dir, remove_after = false)
    Zip::File.open(zip_dir, Zip::File::CREATE) do |zipfile|
      Find.find(dir) do |path|
        Find.prune if File.basename(path)[0] == ?.
        dest = /#{dir}\/(\w.*)/.match(path)
        # Skip files if they exists
        begin
          zipfile.add(dest[1],path) if dest
        rescue Zip::ZipEntryExistsError
        end
      end
    end
    FileUtils.rm_rf(dir) if remove_after
    end



	def replace_in_file(file, string, replace)
	    	 filedata = File.open(file, "rb")
	   	 contents = filedata.read
	   	 contents.gsub! string, replace
	   	 File.open(file, "w+") do |f|
	   		   f.write(contents)
	   	 end
	end




    private
      # Use callbacks to share common setup or constraints between actions.
      def set_android
        @android = Android.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def android_params
        params[:android]
      end
  end
end
