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
      @android = Android.new(android_params)

      if @android.save
        redirect_to @android, notice: 'Android was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /androids/1
    def update
      if @android.update(android_params)
        redirect_to @android, notice: 'Android was successfully updated.'
      else
        render :edit
      end
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
