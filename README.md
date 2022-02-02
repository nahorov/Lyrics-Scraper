# Lyrics Scraper in Bash

This is a simple utility to scrape lyrics off LyricsTranslate.com in any language provided their database has the translation available, and store it in a textfile.

To run, make sure curl 7.79.1 and html2text 2016.1.16 or upward are installed. If not, then install them. Then, <br>
```
$ sh lyrics-scraper.sh $1 $2 $3
```
Or, you could make it into an executable. <br>

```
$ chmod +x lyrics-scraper.sh
$ ./lyrics_scraper.sh $1 $2 $3
```
Wnere, <br>
$1 is the first argument passed to the file during the instance of the execution, the name of the song for which you wish to scrape translated lyrics. <br>
$2 is the second argument passed to the file during the instance of execution, the name of the artist to whom the song is credited. <br>
$3 is the third argument passed to the file during the instance of execution, the target language in which you want to scrape the lyrics in.

For example:<br>
```
$ ./lyrics-scraper.sh "Despacito" "Luis Fonsi" "English"
```
The above command should create a file "despacito-english.txt" in the folder the terminal is working in at the moment.<br>
It is as simple as that and fully functional as is. <br>
Thanks for downloading!<br>
