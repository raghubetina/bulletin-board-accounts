class ListingsController < ApplicationController
  def index
    matching_listings = Listing.all

    @list_of_listings = matching_listings.order({ :created_at => :desc })

    render({ :template => "listing_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_listings = Listing.where({ :id => the_id })

    @the_listing = matching_listings.at(0)

    render({ :template => "listing_templates/show" })
  end

  def create
    the_listing = Listing.new
    the_listing.title = params.fetch("query_title")
    the_listing.body = params.fetch("query_body")
    the_listing.expires_on = params.fetch("query_expires_on")
    the_listing.board_id = params.fetch("query_board_id")
    the_listing.user_id = current_user.id

    if the_listing.valid?
      the_listing.save
      redirect_to("/boards/#{the_listing.board_id}", { :notice => "Listing created successfully." })
    else
      redirect_to("/boards/#{the_listing.board_id}", { :alert => the_listing.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_listing = Listing.where({ :id => the_id }).at(0)

    the_listing.title = params.fetch("query_title")
    the_listing.body = params.fetch("query_body")
    the_listing.expires_on = params.fetch("query_expires_on")
    the_listing.board_id = params.fetch("query_board_id")

    if the_listing.valid?
      the_listing.save
      redirect_to("/listings/#{the_listing.id}", { :notice => "Listing updated successfully." } )
    else
      redirect_to("/listings/#{the_listing.id}", { :alert => the_listing.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_listing = Listing.where({ :id => the_id }).at(0)

    the_listing.destroy

    redirect_to("/boards/#{the_listing.board_id}", { :notice => "Listing deleted successfully." } )
  end
end
