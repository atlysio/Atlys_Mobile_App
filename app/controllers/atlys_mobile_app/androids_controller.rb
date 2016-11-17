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
 
	FileUtils.rm_rf(temp_folder)

	Dir.mkdir Rails.root.to_s+"/tmp/android_app"

	FileUtils.cp_r app_folder, temp_folder

        zipfolder(temp_folder, zip_location)

	send_file zip_location, :type => 'application/zip',
                :disposition => 'attachment',
                :filename => "android_app.zip"

    end




    def zipfolder(dir, zip_dir, remove_after = false)
    Zip::ZipFile.open(zip_dir, Zip::ZipFile::CREATE)do |zipfile|
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

    # DELETE /androids/1
    def destroy
      @android.destroy
      redirect_to androids_url, notice: 'Android was successfully destroyed.'
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
