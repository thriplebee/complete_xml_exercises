for $x in doc("sample.xml")/movies/movie
where $x/cast/actor[@id="a0001"]
order by $x/name
return $x/name/text()