# Need to determine appropriate method of pseudo-whitelisting only
# valid params

module DataProcessing
  extend MatchAlgorithm
  require 'csv'

  #can make filename an ivar later for better style
  def process_csv!
    CSV.foreach(@csv.path, headers: true) do |row|
      idp_attrs = row.to_hash
      evaluate_matches!(idp_attrs)
    end
  end

  # private
  def evaluate_matches!(idp_attrs)
    candidate_matches = TestIdp.all.select do |idp_record|
      match_score(idp_attrs, idp_record) >= 3.5
    end

    if candidate_matches.length == 0
      # new idp
      idp_attrs.delete('id')
      TestIdp.create!(idp_attrs)
    elsif candidate_matches.length == 1
      # new reconciled match
      ReconciledMatch.create!(
      {
        master_dataset_id: candidate_matches.first.id,
        satellite_dataset: @filename,
        satellite_dataset_id: idp_attrs['id']
      })
    else
      # new unreconciled match
      UnreconciledMatch.create!(
      {
        master_dataset_ids: candidate_matches.map(&:id).to_json,
        satellite_dataset: @filename,
        satellite_dataset_id: idp_attrs['id']
      })
    end
  end

  def match_score(idp_attrs, idp_record)
    score = 0

    score += 2 if (idp_attrs['sex'] == idp_record.sex)
    score += 2 if (idp_attrs['age'].to_i - idp_record.age).abs <= 2
    score += 1 if (match_first = (idp_attrs['first_name'] == idp_record.first_name))
    score += 1 if (match_last = (idp_attrs['last_name'] == idp_record.last_name))
    score += 2 if match_first && match_last

    score
  end

  # def valid_idp_params(idp_attrs)
  #   idp_attrs.permit(:first_name, :last_name, :sex, :age)
  # end

end
