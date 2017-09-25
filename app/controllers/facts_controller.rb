class FactsController < ApplicationController

	skip_before_action :verify_authenticity_token
	before_action :authenticate_api_key

	def index
	end

	def create
		return unless validate_fact_json request.body.string

		json = JSON.parse(request.body.string)

		@fact = Fact.new()
		@fact.client_uuid = json['client_uuid']
		json = json['fact']
		@fact.full_text = json['full_text']
		@fact.microdata = json['microdata']
		@fact.source_url = json['source_url']
		@fact.site_id = json['site_id']
		
		json = JSON.parse(json['microdata'])

		@fact.date_published = json['itemReviewed']['datePublished']
		@fact.claim_reviewed = json['claimReviewed']
		@fact.author_type = json['author']['type'] unless json['author']['type'].blank?
		@fact.author_url = json['author']['url'] unless json['author']['url'].blank?
		@fact.author_image = json['author']['image'] unless json['author']['image'].blank?
		@fact.author_same_as = json['author']['sameAs'] unless json['author']['sameAs'].blank?
		@fact.review_type = json['reviewRating']['type'] unless json['reviewRating']['type'].blank?
		@fact.review_rating_value = json['reviewRating']['ratingValue'] unless json['reviewRating']['ratingValue'].blank?
		@fact.review_best_rating = json['reviewRating']['bestRating'] unless json['reviewRating']['bestRating'].blank?
		@fact.review_image = json['reviewRating']['image'] unless json['reviewRating']['image'].blank?
		@fact.review_alternate_name = json['reviewRating']['alternateName'] unless json['reviewRating']['alternateName'].blank?
		@fact.item_reviewed_type = json['itemReviewed']['type'] unless json['itemReviewed']['type'].blank?
		@fact.item_reviewed_date_published = json['itemReviewed']['datePublished'] unless json['itemReviewed']['datePublished'].blank?
		@fact.item_reviewed_name = json['itemReviewed']['name'] unless json['itemReviewed']['name'].blank?
		@fact.item_reviewed_author_type = json['itemReviewed']['author']['type'] unless json['itemReviewed']['author']['type'].blank?
		@fact.item_reviewed_author_name = json['itemReviewed']['author']['name'] unless json['itemReviewed']['author']['name'].blank?
		@fact.item_reviewed_author_job_title = json['itemReviewed']['author']['jobTitle'] unless json['itemReviewed']['author']['jobTitle'].blank?
		@fact.item_reviewed_author_image = json['itemReviewed']['author']['image'] unless json['itemReviewed']['author']['image'].blank?
		@fact.item_reviewed_author_same_as = json['itemReviewed']['author']['sameAs'] unless json['itemReviewed']['author']['sameAs'].blank?

		#byebug
		@fact.save!
		render json: @fact
	end


	private

	def validate_fact_json json_string
		#byebug
		json = JSON.parse(request.body.string)
		return json_error "Request must contain fact object", 2000 if json['fact'].nil?
		return json_error "Request missing client_uuid", 2001 if json['client_uuid'].blank?

		fact = json['fact']

		return json_error "Request missing full_text", 2001 if fact['full_text'].blank?
		return json_error "Request missing microdata", 2001 if fact['microdata'].blank?
		return json_error "Request missing source_url", 2001 if fact['source_url'].blank?
		return json_error "Request missing site_id", 2001 if fact['site_id'].blank?

		fact = JSON.parse(fact['microdata'])
		return json_error "Request missing [claimReviewed]", 2001 if fact['claimReviewed'].blank?
#		return json_error "Request missing author[@type]", 2001 if fact['author']['@type'].blank?
#		return json_error "Request missing author[url]", 2001 if fact['author']['url'].blank?
#		return json_error "Request missing author[image]", 2001 if fact['author']['image'].blank?
#		return json_error "Request missing author[sameAs]", 2001 if fact['author']['sameAs'].blank?
#		return json_error "Request missing review[type]", 2001 if fact['reviewRating']['@type'].blank?
		return json_error "Request missing review[ratingValue]", 2001 if fact['reviewRating']['ratingValue'].blank?
#		return json_error "Request missing review[bestRating]", 2001 if fact['reviewRating']['bestRating'].blank?
#		return json_error "Request missing review[worstRating]", 2001 if fact['reviewRating']['worstRating'].blank?
#		return json_error "Request missing review[image]", 2001 if fact['reviewRating']['image'].blank?
#		return json_error "Request missing review[alternateName]", 2001 if fact['reviewRating']['alternateName'].blank?
#		return json_error "Request missing itemReviewed[type]", 2001 if fact['itemReviewed']['@type'].blank?
#		return json_error "Request missing itemReviewed[datePublished]", 2001 if fact['itemReviewed']['datePublished'].blank?
#		return json_error "Request missing itemReviewed[name]", 2001 if fact['itemReviewed']['name'].blank?
#		return json_error "Request missing itemReviewed[author][type]", 2001 if fact['itemReviewed']['author']['@type'].blank?
#		return json_error "Request missing itemReviewed[author][name]", 2001 if fact['itemReviewed']['author']['name'].blank?
#		return json_error "Request missing itemReviewed[author][jobTitle]", 2001 if fact['itemReviewed']['author']['jobTitle'].blank?
#		return json_error "Request missing itemReviewed[author][image]", 2001 if fact['itemReviewed']['author']['image'].blank?
#		return json_error "Request missing itemReviewed[author][sameAs]", 2001 if fact['itemReviewed']['author']['sameAs'].blank?

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

=begin
	
{
	"client_uuid": "7b91355a-0db0-417e-ae8f-49478054f7eb",
	"api_key": "eR8OBIgXiePBLX8EjltCbMQQ/2zSNVfllmfXZ4ptty4=",
	"fact": {
		"full_text": "This is a fake text.",
		"microdata": "",
		"source_url": "",
    	"client_uuid": "",
    	"site_id": "", 
		"date_published": "",
		"url": "",
		"claim_reviewed": "",
		"author_type": "",
		"author_url": "",
		"author_image": "",
		"author_same_as": "",
		"review_type": "",
		"review_rating_value": "",
		"review_best_rating": "",
		"review_image": "",
		"review_alternate_name": "",
		"item_reviewed_type": "",
		"item_reviewed_date_published": "",
		"item_reviewed_name": "",
		"item_reviewed_author_type": "",
		"item_reviewed_author_name": "",
		"item_reviewed_author_job_title": "",
		"item_reviewed_author_image": "",
		"item_reviewed_author_same_as": ""
	}
}

=end
