
# PESEL Number Generator
# @author kubar3k
class Pesel

  # random digit from 1 to 9 inclusive
  def rand_digit()
    return Random.rand(1..9)
  end

  # random date from year 1900-1999 inclusive, all months, but days from 1 to 28 inclusive
  def rand_date()
    year = ("0" + Random.rand(1..99).to_s)[-2..-1]

    month = ("0" + Random.rand(1..12).to_s)[-2..-1]

    day = ("0" + Random.rand(1..28).to_s)[-2..-1]

    return (year + month + day).split("").map { |d| d.to_i }
  end

  # some unique identifier consisting of 4 digits from 1 to 9
  def rand_uid()
    return [rand_digit(), rand_digit(), rand_digit(), rand_digit()]
  end

  # compute control sum of given number
  # the core of PESEL number algorithm
  def control_sum(numbers)
    a = numbers[0]
    b = numbers[1]
    c = numbers[2]
    d = numbers[3]
    e = numbers[4]
    f = numbers[5]
    g = numbers[6]
    h = numbers[7]
    i = numbers[8]
    j = numbers[9]

    zm = (a + 3*b + 7*c + 9*d + e + 3*f + 7*g + 9*h + i + 3*j) % 10
    zm = (10 - zm) % 10

    return zm
  end

  # generate & return new one
  def to_s()
    numbers = rand_date + rand_uid
    sum = control_sum(numbers)
    numbers << sum
    @generated = numbers
    return @generated.join("")
  end

  # check correctness of generated pesel
  def chk()
    sum = control_sum(@generated)
    return (sum == @generated.last)
  end

  private :rand_digit, :rand_date, :rand_uid, :control_sum
end

# generate either one or given number of PESEL numbers
count = ARGV[0] == nil ? 1 : ARGV[0].to_i
count.times {
  puts Pesel.new.to_s
}

