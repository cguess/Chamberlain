class FactsController < ApplicationController

	skip_before_action :verify_authenticity_token
	before_action :authenticate_api_key

	def index
	end

	def create
		return unless validate_fact_json request.body.string

		@fact = Fact.new(fact_params)
		@fact.save!
		render json: @fact
	end

	private

	def validate_fact_json json_string
		json = JSON.parse(request.body.string)
		return json_error "Request must contain fact object", 2000 if json['fact'].nil?
		fact = json['fact']
		
		return json_error "Request missing full_text", 2001 if fact['full_text'].blank?
		return json_error "Request missing microdata", 2001 if fact['microdata'].blank?
		return json_error "Request missing source_url", 2001 if fact['source_url'].blank?
		return json_error "Request missing client_uuid", 2001 if fact['client_uuid'].blank?
		return json_error "Request missing site_id", 2001 if fact['site_id'].blank?
		return json_error "Request missing claim_reviewed", 2001 if fact['claim_reviewed'].blank?
		return json_error "Request missing author_type", 2001 if fact['author_type'].blank?
		return json_error "Request missing author_url", 2001 if fact['author_url'].blank?
		return json_error "Request missing author_image", 2001 if fact['author_image'].blank?
		return json_error "Request missing author_same_as", 2001 if fact['author_same_as'].blank?
		return json_error "Request missing review_type", 2001 if fact['review_type'].blank?
		return json_error "Request missing review_rating_value", 2001 if fact['review_rating_value'].blank?
		return json_error "Request missing review_best_rating", 2001 if fact['review_best_rating'].blank?
		return json_error "Request missing review_image", 2001 if fact['review_image'].blank?
		return json_error "Request missing review_alternate_name", 2001 if fact['review_alternate_name'].blank?
		return json_error "Request missing item_reviewed_type", 2001 if fact['item_reviewed_type'].blank?
		return json_error "Request missing item_reviewed_date_published", 2001 if fact['item_reviewed_date_published'].blank?
		return json_error "Request missing item_reviewed_name", 2001 if fact['item_reviewed_name'].blank?
		return json_error "Request missing item_reviewed_author_type", 2001 if fact['item_reviewed_author_type'].blank?
		return json_error "Request missing item_reviewed_author_name", 2001 if fact['item_reviewed_author_name'].blank?
		return json_error "Request missing item_reviewed_author_job_title", 2001 if fact['item_reviewed_author_job_title'].blank?
		return json_error "Request missing item_reviewed_author_image", 2001 if fact['item_reviewed_author_image'].blank?
		return json_error "Request missing item_reviewed_author_same_as", 2001 if fact['item_reviewed_author_same_as'].blank?

		return true
	end

  def fact_params
    params.require(:fact).permit(:full_text, :microdata, :source_url,
    														 :client_uuid, :site_id, :last_seen,
    														 :date_published, :url, :claim_reviewed,
    														 :author_type, :author_url, :author_image,
    														 :author_same_as, :review_type, :review_rating_value,
    														 :review_best_rating, :review_image, :review_alternate_name,
    														 :item_reviewed_type, :item_reviewed_date_published,
    														 :item_reviewed_name, :item_reviewed_author_type,
    														 :item_reviewed_author_name, :item_reviewed_author_job_title,
    														 :item_reviewed_author_image, :item_reviewed_author_same_as)
  end

end
