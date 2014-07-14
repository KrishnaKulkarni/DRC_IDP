module MatchAlgorithm
  THRESHOLD_MATCH_SCORE = 3.5

 # candidates is an Array or ActiveRecordRelation of the pool of people to compare
  def generate_matches_list(identity_attrs, candidates)
  	candidates.select do |candidate|
  		evaluate_match_score(identity_attrs, candidate) >= THRESHOLD_MATCH_SCORE
  	end
  end

  # identity_attributes is a hash;  candidate_identity_attrs is a record which responds
  # to similar methods
  def evaluate_match_score(base_identity_attrs, candidate_identity)
  	score = 0

    score += 2 if matches_by("sex", base_identity_attrs, candidate_identity)
    score += 2 if matches_by("age", base_identity_attrs, candidate_identity) do |base, cand|
    	(base.to_i - cand).abs <= 2
    end
    score += 1 if (match_first = matches_by("first_name", base_identity_attrs, candidate_identity))
    score += 1 if (match_last = matches_by("last_name", base_identity_attrs, candidate_identity))
    score += 2 if match_first && match_last

    score
  end

  def matches_by(attrib, base, cand, &operation)
  	return false unless base[attrib] && cand[attrib]

	if operation
 	 	operation.call(base[attrib], cand[attrib])
  	else
  		base[attrib] == cand[attrib]
  	end
  end

end