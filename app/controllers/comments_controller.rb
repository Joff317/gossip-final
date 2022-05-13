class CommentsController < ApplicationController
   before_action :authorize, only: [:new, :edit, :destroy]

   def index 
      @comments = Comment.all.reorder(id: :asc, content: :asc)
      end
   
      
     def new
      @comment = Comment.new 
     end
   

     def create 
      @comment = Comment.new("content" => params[:content],
                            user: current_user,
                            gossip: Gossip.find(params[:gossip_id]))
                           
   
      if @comment.save 
      flash[:success] = "Le commentaire à bien été crée"   
      redirect_to :controller => 'gossips', :action => "show", :id => params[:gossip_id]
      else
         render :action => 'new'
      end
     end
   
     def edit 
      @gossip = Gossip.find(params[:gossip_id])
      @comment = Comment.find(params[:id])
     end

    def update
      @comment = Comment.find(params[:id]) 
      comment_params = params.require(:comment).permit(:content)
      if @comment.update(comment_params)
      flash[:success] = "Le commentaire à bien été modifié"
      redirect_to :controller => 'gossips', :action => "show", :id => params[:gossip_id]
      else 
      render :action => 'edit'
      end   
     end
   
     def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to :controller => 'gossips', :action => "show", :id => params[:gossip_id]
     end
end