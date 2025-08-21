Rails.application.routes.draw do
  get("/", { :controller => "boards", :action => "index" })

  # Routes for the Listing resource:

  # CREATE
  post("/insert_listing", { :controller => "listings", :action => "create" })

  # READ
  get("/listings", { :controller => "listings", :action => "index" })

  get("/listings/:path_id", { :controller => "listings", :action => "show" })

  # UPDATE

  post("/modify_listing/:path_id", { :controller => "listings", :action => "update" })

  # DELETE
  get("/delete_listing/:path_id", { :controller => "listings", :action => "destroy" })

  #------------------------------

  # Routes for the Board resource:

  # CREATE
  post("/insert_board", { :controller => "boards", :action => "create" })

  # READ
  get("/boards", { :controller => "boards", :action => "index" })

  get("/boards/:path_id", { :controller => "boards", :action => "show" })

  # UPDATE

  post("/modify_board/:path_id", { :controller => "boards", :action => "update" })

  # DELETE
  get("/delete_board/:path_id", { :controller => "boards", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end
