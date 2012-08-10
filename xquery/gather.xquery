declare namespace jhove = "http://hul.harvard.edu/ois/xml/ns/jhove";
<results> {
for $tiff in collection("../metadata?select=*.xml;recurse=yes")
return
  <tiff uri="{replace($tiff/jhove:jhove/jhove:repInfo/@uri/string(),'%5C','/')}">
      <lastModified>{$tiff/jhove:jhove/jhove:repInfo/jhove:lastModified/string()}</lastModified>
      <size>{$tiff/jhove:jhove/jhove:repInfo/jhove:size/string()}</size>
      <status>{$tiff/jhove:jhove/jhove:repInfo/jhove:status/string()}</status>
      {$tiff/jhove:jhove/jhove:repInfo/jhove:messages}
  </tiff>
} </results> 