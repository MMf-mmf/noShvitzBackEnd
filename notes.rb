require 'json'

grades = { "Bob" => 82,
"Jim" => 94,
"Billy" => 58
}


items = {82 => "Bob" }

# p items[82]
# p grades[items[82]]
items['mendel'] = 32
items['mendel'] = items['mendel'] + 3
items = items.to_json #.gsub!(/\"/, '\'')
p items = JSON.parse(items)

p items['hello']
if items['hello'] != nil
    puts 'it was nil'
    
end