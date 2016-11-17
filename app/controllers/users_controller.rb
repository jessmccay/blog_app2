class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @user = cookies[:user_id]
      if !cookies[:user_id].nil?
        render :do_login
      else
        render :index
      end

  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
    render :login
  end

  def do_login
    # if !cookies[:user_id].nil?
    #   render :do_login



    if !params[:login_email].nil? && !params[:login_email].strip.empty? && !params[:login_password].nil? &&  !params[:login_password].strip.empty?
    #finds matching email in database, once found stores all info from that user object into a user instance
      @user = User.find_by_email(params[:login_email])



        #as long as the user exists
      if !@user.nil?
         #compares the stored password for that user against the password entered
        if @user.password == params[:login_password]
        cookies[:user_id] = @user.id
        # render text: "You got log in!"
        #render :login_confirm
        else
         flash[:notice]= "Please try again"
        end

      else
       flash[:notice]= "Please enter a valid email"
      end

    else
      render :login
    end
  end #do_login


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def logout
    cookies.delete :user_id
    redirect_to '/users/login'
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:full_name, :email, :password)
    end
end


def splay
  @user = User.find(cookies[:user_id])
end
