(:~ ################### XQueries ################### ~:)

(:~ ######### Basic FLOWR ######### ~:)

(:~ Select name elements of all movies which imdb rating is greater than 7.0 ~:)
for $x in doc("sample.xml")/movies/movie
where $x/imdb > 7.0
return $x/name

(:~ ---------------- ~:)

(:~ Select name elements of all movies which released after 2021-08-01 ~:)
for $x in doc("sample.xml")/movies/movie
where $x/release > "2021-08-01"
order by $x/name descending
return $x/name

(:~ ---------------- ~:)

(:~ Select actor names of Antlers movie ~:)
for $x in doc("sample.xml")/movies/movie
where $x[name="Antlers"]
order by $x/name
return $x/cast/actor/name/text()

(:~ ---------------- ~:)

(:~ Select name and boxoffice of all movies which language is hindi ~:)
for $x in doc("sample.xml")/movies/movie
where $x/name[@lang="hi"]
order by $x/name
return $x/name/text() | $x/boxoffice/text()

(:~ ---------------- ~:)

(:~ Select name and imdb of all movies which language is not english ~:)
for $x in doc("sample.xml")/movies/movie
where $x/not(name[@lang="en"])
order by $x/name
return $x/name/text() | $x/imdb/text()

(:~ ---------------- ~:)

(:~ Select name and age elements of actors in all movies which age is greater than 40 ~:)
for $x in doc("sample.xml")/movies/movie/cast/actor
where $x/age > 40
order by $x/age
return $x/name | $x/age

(:~ ---------------- ~:)

(:~ Select name of all movies which a0001 actor participated ~:)
for $x in doc("sample.xml")/movies/movie
where $x/cast/actor[@id="a0001"]
order by $x/name
return $x/name/text()

(:~ -------------------------------- ~:)

(:~ ######### Generate HTML Output ######### ~:)

(:~ Add name elements of all movies to a HTML structure which imdb rating is greater than 7.0 ~:)
<ul>
  {
    for $x in doc("sample.xml")/movies/movie
    where $x/imdb > 7.0
    order by $x/imdb descending
    return <li><a href="#">{data($x/name)}</a></li>
  }
</ul>

(:~ ---------------- ~:)

(:~ Add all Antlers movie details to a HTML structure  ~:)
<div class="movie">
  {
    for $x in doc("sample.xml")/movies/movie
    where $x[name="Antlers"]
    order by $x/name
    return <h1 class="heading">{$x/name/text()}</h1> |
    <div class="details">
      <p>{$x/release/text()}</p>
      <p>{$x/country/text()}</p>
      <p>{$x/imdb/text()}</p>
      <p>{$x/boxoffice/text()}</p>
    </div>
  }
</div>

(:~ -------------------------------- ~:)

(:~ ######### If Then Else ######### ~:)

(:~ Return movie names of all movies which language is not hindi if sample.xml file exist ~:)
if(not(doc("sample.xml"))) then (
  <error>
     <message>{"Hindi movies not supported"}</message>
  </error>
)
else (
  for $x in doc("sample.xml")/movies/movie
  where $x/not(name[@lang="hi"])
  return $x/name
)

(:~ Return a new length element if the language of movie is hindi and return a new region element for movies with other languages ~:)
for $x in doc("sample.xml")/movies/movie
return if($x/name[@lang="hi"])
then <length>{"Over 2 Hours"}</length>
else <region>{"America / Europe"}</region>

(:~ -------------------------------- ~:)

(:~ ######### Sequences ######### ~:)

(:~ Select a specific data elements in a sequence using position ~:)
let $sequence := (22, 2, 3, 7, 50, 6)
return
  <output>
    <elements>
      {
        for $element in $sequence[1]
        return <element>{$element}</element>
      }
    </elements>

  </output>

(:~ ---------------- ~:)

(:~ Select a specific data elements in a sequence using value ~:)
let $sequence := ("a", "b", "c", "d", "e", "f")
return
  <output>
    <elements>
      {
        for $element in $sequence[. = ("c", "e", "f")]
        return <element>{$element}</element>
      }
    </elements>

  </output>

(:~ ---------------- ~:)

(:~ Select different data elements from a given sequence by iteraing the sequence one by one ~:)
let $sequence := ("Antlers", <actor/>, <movie type="action"/>, <boxoffice type="wordlwide">"100 M. USD"</boxoffice>, 1, 2, 3, "a", "b", "abc")
return
  <output>
    <elements>
      {
        for $element in $sequence
        return <element>{$element}</element>
      }
    </elements>

  </output>

(:~ -------------------------------- ~:)

(:~ ######### Sequence Functions ######### ~:)

(:~ Count number of elements, sum of all elements and average of all elements from a given sequence ~:)
let $sequence := (33, 4, 55, 66, 21, 10, 3, 1, 22)
let $count := count($sequence)
let $sum := sum($sequence)
let $avg := avg($sequence)
return
  <output>
    <count>{$count}</count>
    <sum>{$sum}</sum>
    <avg>{$avg}</avg>
  </output>

(:~ ---------------- ~:)

(:~ Minimum and maximum element from a given sequence ~:)
let $sequence := (33, 4, 55, 66, 21, 10, 3, 1, 22)
let $min := min($sequence)
let $max := max($sequence)
return
  <output>
    <min>{$min}</min>
    <max>{$max}</max>
  </output>

(:~ ---------------- ~:)

(:~ Unique elements from a given sequence ~:)
let $sequence := (33, 4, 55, 66, 21, 4, 10, 3, 1, 22, 33, 66)
let $uniqueElements := distinct-values($sequence)
return
  <output>
    <elements>
      {
        for $element in $uniqueElements
        order by $element descending
        return <element>{$element}</element>
      }
    </elements>
  </output>

(:~ ---------------- ~:)

(:~ Sub sequence from a given sequence ~:)
let $sequence := (33, 4, 55, 66, 21, 4, 10, 3, 1, 22, 33, 66)
let $subSequence := subsequence($sequence, 3, 5)
return
  <output>
    <elements>
      {
        for $element in $subSequence
        return <element>{$element}</element>
      }
    </elements>
  </output>

(:~ ---------------- ~:)

(:~ Reverse the a given sequence ~:)
let $sequence := (33, 4, 55, 66, 21, 4, 10, 3, 1, 22, 33, 66)
let $reverseSequence := reverse($sequence)
return
  <output>
    <elements>
      {
        for $element in $reverseSequence
        return <element>{$element}</element>
      }
    </elements>
  </output>

(:~ ---------------- ~:)

(:~ Elements positioned in odd positions from a given sequence ~:)
let $sequence := (33, 4, 55, 66, 21, 4, 10, 3, 1, 22, 33, 66)
return
  <output>
    <elements>
      {
        for $element in $sequence[position() mod 2 eq 1]
        return <element>{$element}</element>
      }
    </elements>
  </output>

(:~ ---------------- ~:)

(:~ Position of an element from a given sequence ~:)
let $sequence := (33, 4, 55, 66, 21, 4, 10, 3, 1, 22, 33, 66)
let $indexOf := index-of($sequence, 21)
return
  <output>
    <position>{$indexOf}</position>
  </output>

(:~ -------------------------------- ~:)

(:~ ######### String Functions ######### ~:)

(:~ Length of a string ~:)
let $text := "Subscribe ThripleBee Youtube Channel"
let $size := string-length($text)

return
   <output>
      <size>{$size}</size>
   </output>

(:~ ---------------- ~:)

(:~ Combine 2 strings ~:)
let $text := "Subscribe ThripleBee"
let $updatedText := concat($text, " Youtube Channel")

return
   <output>
      <text>{$updatedText}</text>
   </output>

(:~ ---------------- ~:)

(:~ Get a string by concatenating the items in a sequence with a defined sperator ~:)
let $movies :=
<movies>
   <movie>Antlers</movie>
   <movie>Jungle Cruise</movie>
   <movie>Red Notice</movie>
   <movie>Karnan</movie>
</movies>

return
  <output>

     <movies>
       {
          string-join($movies/movie, ',')
       }
     </movies>
  </output>

(:~ -------------------------------- ~:)

(:~ ######### Date & Time Functions ######### ~:)

(:~ Get the current date ~:)
let $date := current-date()

return
  <output>
    <date>{$date}</date>
  </output>

(:~ ---------------- ~:)

(:~ Get the current time ~:)
let $time := current-time()

return
  <output>
    <time>{$time}</time>
  </output>

(:~ ---------------- ~:)

(:~ Get the current date & time ~:)
let $dateTime := current-dateTime()

return
  <output>
    <datetime>{$dateTime}</datetime>
  </output>


(:~ -------------------------------- ~:)

(:~ ######### Regular Expressions ######### ~:)

(:~ Check if the string matches with the given regular expression ~:)
let $input := 'Subscribe ThripleBee Youtube Channel'
return (
  matches($input, "Youtu ") =  true(),
  matches($input, "S.* T.* Y.* C.*") =  true()
)

(:~ ---------------- ~:)

(:~ Replaces the matched string with a given regular expression ~:)
let $input := 'Youtube 2022... Channel'
return (
  replace($input, "Youtube (\d\d)", "ThripleBee")
)

(:~ ---------------- ~:)

(:~ Get sequence of strings constructed by splitting the string wherever a regular expression/seperator is found ~:)
let $input := 'Subscribe Thriplebee Youtube Channel'
return (
  tokenize($input, "b")
)


(:~ -------------------------------- ~:)

(:~ ######### Custom Functions ######### ~:)

(:~ Add to numbers ~:)
declare function local:addNumbers(
  $number1 as xs:decimal?,
  $number2 as xs:decimal?
)
{
  let $sum := $number1 + $number2
  return $sum
};
<sum>{local:addNumbers(25.54, 10.25)}</sum>

(:~ ---------------- ~:)

(:~ Calculate the area of a circle ~:)
declare function local:areaOfCircle(
  $radius as xs:decimal?
)
{
  let $area := (22 div 7) * $radius * $radius
  return $area
};
<area>{local:areaOfCircle(12)}</area>

(:~ ---------------- ~:)

(:~ Check if number is an even or odd ~:)
declare function local:oddOrEven(
  $number as xs:integer?
)
{
  if ($number mod 2 = 0) then (
    <number>Even</number>
  )
  else (
    <number>Odd</number>
  )
};
local:oddOrEven(5)

(:~ ---------------- ~:)

(:~ Get the grade based on marks ~:)
declare function local:getGrade(
  $marks as xs:integer?)
{
  if ($marks >= 75) then (
    <grade>B</grade>
  )
  else (
    if($marks >= 65) then (
      <grade>B</grade>
    )
    else(
      if($marks >= 55) then (
        <grade>C</grade>
      )
      else(
        if($marks >= 35) then (
          <grade>S</grade>
        )
        else(
          <grade>F</grade>
        )
      )
    )
  )
};
local:getGrade(33)
