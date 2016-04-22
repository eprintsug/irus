# Example code to add a custom set with possible ORCIDs in the 'creators_id' field
# If you store ORCIDs in another field, this will need to be reflected in thefilter settings
# 
#push @{$c->{oai}->{custom_sets}}, { spec => "irus-orcid", name => "IRUS: Records with ORCIDs", filters => [
#       { meta_fields => [ "creators_id" ], value => "0000-", match => "IN", },
#] };
