module ControllerMethods

  def self.included(base)
     base.class_eval do
       before_filter :authenticate_user!
       before_filter :load_item, :except => [:new, :index, :create]
     end
  end

  def new
  	@item = current_user.send(class_name).new
  	render layout: false
  end

  def index
  	@items = current_user.send(class_name).page(params[:page]).per(5)
  end

  def create
  	@item = current_user.send(class_name).build(params[model_name])
   	@item.save
    respond_back
  end

  def edit
  	render layout: false
  end

  def update
    @item.update_attributes(params[model_name])
    respond_back
  end

  def destroy
    @item.destroy
    redirect_to redirect_path
  end

  def load_item
    @item = current_user.send(class_name).find(params[:id])
  end

  def respond_back
    respond_to do |format|
      format.html { redirect_to redirect_path }
      format.js { render action: "post_action" }
    end
  end

end