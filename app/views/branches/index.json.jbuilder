json.array!(@branches) do |branch|
  json.extract! branch, :id, :uid, :parent, :text, :range
  json.url branch_url(branch, format: :json)
end
