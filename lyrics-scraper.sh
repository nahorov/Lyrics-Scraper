#!/bin/bash

# The following code is to URL-encode the first two arguments passed and to check if a third argument has been passed. 
# URL-encoding ensures that special and reserved characters are converted to their ASCII Hex values to make the URL-friendly.
song_encoded=$(echo -ne "$1" | hexdump -v -e '/1 "%02x"' | sed 's/\(..\)/%\1/g')
artist_encoded=$(echo -ne "$2" | hexdump -v -e '/1 "%02x"' | sed 's/\(..\)/%\1/g')
lang_check=$(echo "$3")

if [[ -z ${1} ]]; # If an argument for song name has not been passed, set the variable to zero, else, set it to the url-encoded argument.
then
	song_encoded="0"
else
	continue
fi

if [[ -z ${2} ]]; # If an argument for artist name has not been passed, set the variable to zero, else set it to the url-encoded argument.
then
	artist_encoded="0"
else
	continue
fi

if [[ -z lang_check ]]; # If an argument for language has not been passed, set the variable to "None"; else, normalize the string and make it all lowercase to avoid discrepancies and keep the case statement simple since Bash is case-sensitive.
then
	language_raw="None"
else
	language_raw=$(echo "$3" | awk '{print tolower($0)}')
	continue
fi

# Lyricstranslate.com has a numbers-based representation for language in their URLs during the advanced search function. Therefore, you cannot directly plug the url-encoded string for language into the URL, you have to match it with the number that they use. These numbers have been assigned only by LyricsTranslate and aren't universal values that could be accepted on another site. 
case $language_raw in

	albanian)
		language_encoded="319"
		;;

	apache)
		language_encoded="1037266"
		;;

	arabic)
		language_encoded="12"
		;;

	azerbaijani)
		language_encoded="433"
		;;

	belarusian)
		language_encoded="317"
		;;

	bosnian)
		language_encoded="318"
		;;

	bulgarian)
		language_encoded="14"
		;;

	catalan)
		language_encoded="342"
		;;

	chinese)
		language_encoded="15"
		;;

	croatian)
		language_encoded="16"
		;;

	czech)
		language_encoded="17"
		;;

	danish)
		language_encoded="18"
		;;

	dutch)
		language_encoded="19"
		;;

	english)
		language_encoded="328"
		;;

	estonian)
		language_encoded="326"
		;;

	ewe)
		language_encoded="1037263"
		;;

	fiji%20hindi)
		language_encoded="1037269"
		;;

	filipino)
		language_encoded="373"
		;;

	tagalog)
		language_encoded="373"
		;;

	finnish)
		language_encoded="21"
		;;

	french)
		language_encoded="22"
		;;

	fulani)
		language_encoded="1037262"
		;;

	german)
		language_encoded="23"
		;;
	
	greek)
		language_encoded="24"
		;;

	guernesiais)
		language_encoded="1037270"
		;;

	gullah)
		language_encoded="1037261"
		;;

	hebrew)
		language_encoded="26"
		;;

	hindi)
		language_encoded="27"
		;;

	hungarian)
		language_encoded="28"
		;;

	indonesian)
		language_encoded="29"
		;;

	italian)
		language_encoded="30"
		;;

	japanese)
		language_encoded="31"
		;;

	kazakh)
		language_encoded="374"
		;;

	korean)
		language_encoded="32"
		;;

	latin)
		language_encoded="33"
		;;

	latvian)
		language_encoded="325"
		;;

	lithuanian)
		language_encoded="324"
		;;

	macedonian)
		language_encoded="314"
		;;

	malay)
		language_encoded="444"
		;;

	norwegian)
		language_encoded="36"
		;;

	other)
		language_encoded="1025951"
		;;

	persian)
		language_encoded="322"
		;;

	polish)
		language_encoded="37"
		;;

	portuguese)
		language_encoded="38"
		;;

	romanian)
		language_encoded="312"
		;;

	russian)
		language_encoded="40"
		;;

	serbian)
		language_encoded="41"
		;;

	spanish)
		language_encoded="42"
		;;

	swedish)
		language_encoded="43"
		;;

	thai)
		language_encoded="47"
		;;

	tongan)
		language_encoded="801"
		;;

	transliteration)
		language_encoded="718"
		;;

	turkish)
		language_encoded="313"
		;;

	ukrainian)
		language_encoded="48"
		;;

	uzbek)
		language_encoded="323"
		;;

	*)
		language_encoded="0"
		;;

esac

# This is the function to plug in the variables we generated in the program until now into the URL which will then be used to generate the search result.
search_url=$(echo "https://lyricstranslate.com/en/translations/0/$language_encoded/$artist_encoded/$song_encoded/none/0/0/0/0")

# This is to convert the first and third arguments passed to lower-case to use them as variables during naming of the final file.
file_song_name=$(echo "$1" | awk '{print tolower($0)}')
file_language_name=$(echo "$3" | awk '{print tolower($0)}')

# To download the HTML code of webpage at the URL we just generated
echo "Fetching raw data from $search_url, please wait..."
curl $search_url > .tmp_input.html
if grep -q "Your search yielded no results." .tmp_input.html; # If the search query didn't yield any results, the program is to be terminated
then
	echo "Sorry. Your search yielded no results. Please try again and check if the arguments provided were correct."
	rm -rf .tmp_input.html
else
	# Pruning of the raw data to find the short-hand link of the webpage we want.
	grep "<a href" < .tmp_input.html | sed -r 's#^.*<a href="([^"]+)">([^<]+)</a>.*$#\1\t\2#' > .tmp_search_output.txt
	cat .tmp_search_output.txt | grep "$1" > .tmp_search_results.txt
	extension=$(cat .tmp_search_results.txt | awk '{print $1}' | sed -z 's/<div//g' | sed -z 's/\n//g' | sed 's/\.html.*/.html/')
	echo "$extension"
	# Creation of the URL where the lyrics we want are located on the webpage by attaching the pruned short-hand link we acquired through the above code
	song_url=$(echo "https://lyricstranslate.com$extension")
	echo "Fetching raw data from $song_url, please wait..."
	curl $song_url | html2text > .tmp_lyrics_raw.txt
	cat .tmp_lyrics_raw.txt | sed -n '/A A/,$p' | sed -n '/Thanks! ❤|/q;p' > "${file_song_name}-${file_language_name}.txt"
	
	# Garbage-disposal, we don't need these files anymore.
	rm -rf .tmp_input.html .tmp_search_output.txt .tmp_search_results.txt .tmp_lyrics_raw.txt 

	# To indicate the process is over and the job has been done.
	echo "Success! File ${file_song_name}-${file_language_name}.txt has been created."
	
fi

# Thank you!

