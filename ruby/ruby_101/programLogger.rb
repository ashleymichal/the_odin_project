def log description, &someBlock
  if !$nestingDepth
    $nestingDepth = 0
  end
  puts '   '*$nestingDepth + 'Beginning "' + description + '"...'
  $nestingDepth += 1
  result = someBlock.call
  $nestingDepth -= 1
  puts '   '*$nestingDepth + '..."' + description + '" finished, returning ' + result.to_s
end

log "outer block" do
  true
  log "some little block" do
    42
    log "teeny-tiny block" do
      "lots of love"
    end
  end
  log "yet another block" do
    "I love Indian food!"
  end
end