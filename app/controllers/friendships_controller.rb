class FriendshipsController < ApplicationController
  
 def invitation
   user = current_user
   recipient = params[:email]    
     UserMailer.deliver_invite(user, recipient)
     flash[:notice] = "Invitation Sent"  
      respond_to do |format|
       format.html
       format.js 
      end
 end
   
 def index
    @lookup = params[:search]
    @result= User.find(:first, :conditions =>['email = ?', @lookup ]) 
    @friends = current_user.friends
    respond_to do |format|
      format.html
      format.js 
    end
 end
 
  def show   
    @friends = current_user.friends
    @pending_by_me = current_user.pending_friends_by_me
    @pending_for_me = current_user.pending_friends_for_me  
  end
  
  def new
   @user=current_user
   @rf = User.find(params[:id])
   @user.request_friendship_with @rf
   flash[:notice] = "sent friendship request to #{@rf.login.capitalize} " 
   redirect_to :back 
 end 
  
  def accept
    @user=current_user    
    @accept = User.find(params[:id])
    @user.accept_friendship_with @accept    
     redirect_to :back
  end
  
  def sever
    @user = current_user
    @id = params[:id]
    @sever = User.find(@id)
    @user.delete_friendship_with @sever
    flash[:notice] = "friendship canceled"  
    redirect_to :back      
  end  
  
  
end
