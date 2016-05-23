
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

def has_values_after?(counter,number_string)
	number_string[counter + 1..counter + 3].to_i > 0 # has values in the next three digits
end

def has_value_inside_large_num?(counter, number_string)
		# greater than thousand and has value inside three digits 
		(number_string[counter..-1].to_i > 1000) && (number_string[counter + 1..counter+2].to_i > 0 ) 
end

def is_large_number?(current_number_size)
	# greater than 4 digits and is a large number (has power of 3 - divisible by 3)
	(current_number_size >= 4) && ((current_number_size - 4) % 3 == 0) 
end	

def get_next_three_digits(counter, number_string)
	number_string[counter..(counter + 2)].to_i
end

def check_under_hundred (two_digit_n)
	string = ''

	# if less than 10 and not zero, add single number
	if two_digit_n < 10 
					string += $by_one[two_digit_n] if two_digit_n != 0
	# else if a teen, add a teen	
	elsif 20 > two_digit_n && two_digit_n >= 10
			 		string += $teens[two_digit_n.to_s[-1].to_i]
	
	# otherwise cover the two digit number as is
	else
			# get the first of two digits and find the ten
			string += $by_ten[two_digit_n.to_s[0].to_i - 2]

			# if last digit not zero, add single digit
			if two_digit_n.to_s[-1].to_i != 0
					string += '-' + $by_one[two_digit_n.to_s[-1].to_i] 
			end
	end

	string
end

def check_under_thousand(three_digit_s)
	word_string = ''

	three_digit_n = three_digit_s.to_i
	two_digit_n = three_digit_s[1..-1].to_i

	# get values inside one hundred
	word_string += check_under_hundred(two_digit_n)

	# if greater than zero
	if three_digit_s.to_i > 0
		# two digit num is greate than zero add 'and'
	  splitter = 0 < two_digit_n  ? ' and ' : ' ' 
	 else 
	 	splitter = ''
	end

	# if greater than one hundre add the hundred accordingly
	if three_digit_n > 99
			word_string = $by_one[three_digit_s[0].to_i] + ' hundred' + splitter + word_string
	end
	word_string
end




def process_number(number)
		$base_phrase = '' # initial phrase
		number_string = number.to_s # string form of number
		size_of_number	= number_string.length # how many characters it holds
		
		counter = 0

		if number == 0
			return 'zero'
		end
		skip_under_thousand_processing = false # 
		is_large_number = false # turns true if current_number is at the position of a large number plage

		
		# each loop is through a large_num or pushes itself to 
		# the next large and its containing hundreds and thousands 

		while  counter < size_of_number  
			current_number_size = size_of_number - counter

			is_large_number = false

			# CHECK FOR AND DO WORK ON LARGE_NUMS
			# ------------------------------------
			if is_large_number?(current_number_size) 
					
					# if has looped already and have a value in or around them

					if  counter > 1 && has_value_inside_large_num?(counter,number_string)
						$base_phrase += ' '  
					end

					 # if greater than one thousand 
					 # and has value inside the next 3 digits 
					 # or has been skipped or is a thousand place

					if (current_number_size >= 4) && (has_value_inside_large_num?(counter,number_string) || skip_under_thousand_processing || counter == 0)
								$base_phrase += $large_nums[(current_number_size - 4) / 3]  
					end

					#if loop begins a large_num, add a single digit

					if counter == 0  
			 	  	$base_phrase = $by_one[number_string[counter].to_i] + ' ' + $base_phrase  
			 		end


			 		# check if there are values trailing the large num
			 		if has_values_after?(counter, number_string) 
						$base_phrase += ', '
					end	


					is_large_number = true # tell the code below it's a large num
					counter += 1 # get next number
					skip_under_thousand_processing = false # reset skip value


			# IF NOT LARGE NUMS, DO SPECIALIZED INSIDE THOUSAND PROCESSING TO FIND NEXT LARGE NUM
			#------------------------------------------------------------------------------------
			# if not large number but greater than one thousand e.g 10,000
			elsif current_number_size > 4 
					
					if current_number_size % 3 == 2 # e.g 10,000 
						
						$base_phrase += check_under_hundred(number_string[counter..counter+1].to_i)
						counter += 1
						$base_phrase += ' '

					else # e.g 100,000

						$base_phrase += check_under_thousand(number_string[counter..counter+2])

						counter += 2
					end

					skip_under_thousand_processing = true # 
			end

			# PROCESS INSIDE 1000 (three zeros) AND ADD TO BASE
			# -------------------------------------------------
			if !skip_under_thousand_processing # skipped no processing of inside 1000 will happen

				if (three_digit = get_next_three_digits(counter, number_string)) < 100

					# if less than 100, add zero padding
					three_digit = ('0' + three_digit.to_s) 
				else
					# get string version of three digit
					three_digit = three_digit.to_s
				end

				# send three digits as long as 
				if !(counter + 1 == size_of_number && size_of_number > 1)
					$base_phrase += check_under_thousand(three_digit) 
				end

				# if is large number skip the next two digits, else skip to the end
				is_large_number ? counter += 2 : counter += size_of_number 
			end



			# END OF LOOP
		end

		# return full phrase without trailing spaces
		$base_phrase.rstrip 
end

					
							


if __FILE__ == $0
	number_to_word_converter
end