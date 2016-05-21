require 'pry'
$by_one = ['zero','one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
$teens = ['ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen','nineteen']
$by_ten = ['twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']
$large_nums = ['thousand', 'million', 'billion', 'trillion', 'quadrillion', 'quintillion', 'sextillion', 'septillion', 'octillion', 'nonillion', 'decillion', 'undecillion', 'duodecillion', 'tredecillion', 'quattuordecillion', 'quindecillion', 'sexdecillion', 'septendecillion', 'octodecillion', 'novemdecillion', 'vigintillion']

$base_phrase = ''

def number_to_word_converter
	loop do 
			puts "Welcome to the Number to Word Converter, please type in your number (type 'q' to quit): \n"
		query = gets.chomp
		if  query == 'q'
			break
		elsif query.to_i.kind_of? Integer 
				puts process_number(query.to_i)
		end
	end
end

def process_number(number)
		$base_phrase = ''
		number_string = number.to_s
		size_of_number	= number_string.length
		counter = 0
		if number == 0
			return 'zero'
		end
		skip = false
		while  counter < size_of_number 
			current_number_size = size_of_number - counter
			# check if on a break point
			hit = false

			if current_number_size >= 4 && (current_number_size - 4) % 3 == 0
				# large nums

					$base_phrase += ' ' if counter > 1 && $base_phrase[-1] != ' ' && (number_string[counter..-1].to_i > 1000 && number_string[counter + 1..counter+2].to_i > 0)
					$base_phrase += $large_nums[(current_number_size - 4) / 3] if current_number_size >= 4 && ((number_string[counter + 1..counter+2].to_i > 0 && number_string[counter..-1].to_i > 1000)  || skip || counter == 0)
			 	  $base_phrase = $by_one[number_string[counter].to_i] + ' ' + $base_phrase  if counter == 0  
					$base_phrase += ', '	if number_string[counter + 1..counter + 3].to_i > 0 
					hit = true
					counter += 1
					skip = false
			elsif current_number_size > 4  
					if current_number_size % 3 == 2 # e.g 10,000 
						$base_phrase += check_under_hundred(number_string[counter..counter+1].to_i)
						counter += 1
						$base_phrase += ' '
					else # e.g 100,000

						$base_phrase += check_under_thousand(number_string[counter..counter+2])

						counter += 2
					end

					skip = true
			end

			if !skip # skip if next will be large_num
				if (three_digit = number_string[counter..(counter + 2)].to_i) < 100
					three_digit = ('0' + three_digit.to_s) 
				else
					three_digit = three_digit.to_s
				end
				$base_phrase += check_under_thousand(three_digit) if !(counter + 1 == size_of_number && size_of_number > 1)
				hit ? counter += 2 : counter += size_of_number
			end
		end
		$base_phrase.rstrip
end

def check_under_hundred (two_digit_n)
	string = ''
				if two_digit_n < 10 
								string += $by_one[two_digit_n] if two_digit_n != 0
				elsif 20 > two_digit_n && two_digit_n >= 10
						 		string += $teens[two_digit_n.to_s[-1].to_i]
				else
								string += $by_ten[two_digit_n.to_s[0].to_i - 2]
								string += '-' + $by_one[two_digit_n.to_s[-1].to_i] if two_digit_n.to_s[-1].to_i != 0
				end
	string
end

def check_under_thousand(three_digit_s)
	word_string = ''
	three_digit_n = three_digit_s.to_i
	two_digit_n = three_digit_s[1..-1].to_i
	word_string += check_under_hundred(two_digit_n)
	if three_digit_s.to_i > 0
	  splitter = 0 < two_digit_n  ? ' and ' : ' ' 
	 else 
	 	splitter = ''
	end
	if three_digit_n > 99
			word_string = $by_one[three_digit_s[0].to_i] + ' hundred' + splitter + word_string
	end
	word_string
end

if __FILE__ == $0
number_to_word_converter
end