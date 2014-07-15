
def compute_entropy(password)
  password.split("").uniq.length
end

if ARGV.length > 0

  pwd = ARGV[0]

  entropy = compute_entropy(pwd)
  print "#{entropy}"

end
