# Lyrics Scraper in Bash

This is a simple utility to scrape lyrics off LyricsTranslate.com in any language provided their database has the translation available, and store it in a textfile.

To run, make sure curl 7.79.1 and html2text 2016.1.16 or upward are installed. If not, then install them. Then, <br>
```
$ sh install.sh
```
That will install the script to the /usr/bin folder and make it available for use everywhere on the computer. Using the utility is as simple as
```
$ lyrics-scraper SONG ARTIST LANGUAGE
```
Wnere, <br>
SONG is the first argument passed to the script during the instance of the execution, the name of the song for which you wish to scrape translated lyrics. <br>
ARTIST is the second argument passed to the script during the instance of execution, the name of the artist to whom the song is credited. <br>
LANGUAGE is the third argument passed to the script during the instance of execution, the target language in which you want to scrape the lyrics in.

For example:<br>
```
$ lyrics-scraper "foo" "bar" "Spanish"
```
The above command should create a file "foo-spanish.txt" in the present working directory<br><br>

If you have to translate a song which is in another script than Roman (say Cyrillic), use the original for best encoding experience:
```
$ lyrics-scraper "фу" "бар" "English"
```
You could also use it by mentioning only a keyword in the name of the song for some songs in the first argument instead of entire name of the song. Sometime because of the irregularity of the database, it is even necessary that you do so. <br>
You could also pass only the name of the song and no other arguments, though passing of language desired is highly recommended. <br>
You can get away with passing only the name of the song and passing the desired language, but passing no artist. But the script needs to be informed that you are choosing to not enter the name of the artist by including a pair of inverted commas with nothing between them as the second argument. <br>
For example: <br>
```
$ lyrics-scraper "foo" "" "English"
```

This will get the translation present at the first link that appears in the search. <br>
The name of the song and the name of the artist will also be mentioned at the very top of the text file that is generated. <br>
It is simple to use, and fully-functional as is. <br><br>
Thank you for downloading!<br>
