class Testers::Algorithm
  require 'levenshtein'

  def self.dosomething
	candidates = GoldStandardIdentity.all
		 #    matches = generate_matches_list(gold_standard_identity_params, candidates)

		 #    candidates

	output = Levenshtein.distance('James', 'Jones', threshold = nil, options = {})

	p output
	
  end
end