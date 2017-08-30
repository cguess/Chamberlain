class CreateFacts < ActiveRecord::Migration[5.1]
  def change
    create_table :facts do |t|
    	# The full schema element, as found in the wild
    	t.string :full_text
    	# What format the schema element was found in, 
    	# if this is false then JSON-LD is assumed (for now)
    	t.boolean :microdata, default: false
    	# The full url where the schema was found
    	t.string :source_url, index: true
    	# The uuid of the client that submitted the schema
    	t.string :client_uuid
    	# The site object's id this schema is associated with
	    t.integer :site_id
	    # The last time this schema element was submitted
	    t.datetime :last_seen, default: DateTime.now
	    # The number of times this schema element has been seen
	    t.integer :times_seen, default: 0
	    # General timestamps
      t.timestamps

    	# Schema.org ClaimReview elements
    	# https://schema.org/ClaimReview
    	# This doesn't include everything, but it covers the major stuff
	    t.string :date_published
	    t.string :url
	    t.string :claim_reviewed

	    # Author object
	    t.string :author_type
	    t.string :author_url
	    t.string :author_image
	    t.string :author_same_as

	    # Review rating object
	    t.string :review_type
	    t.string :review_rating_value
	    t.string :review_best_rating
	    t.string :review_image
	    t.string :review_alternate_name

	    # Item Reviewed object
	    t.string :item_reviewed_type
	    t.datetime :item_reviewed_date_published
	    t.string :item_reviewed_name
	    # Item Reviewed Author object
	    t.string :item_reviewed_author_type
	    t.string :item_reviewed_author_name
	    t.string :item_reviewed_author_job_title
	    t.string :item_reviewed_author_image
	    t.string :item_reviewed_author_same_as
    end
  end
end
