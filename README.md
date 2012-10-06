watson-scripts
==============
- copy build.TEMPLATE.properties to build.properties; use as-is or edit to set directory paths
  - the only one that needs to be changed for production is data, pointing to where the data sits
- run "ant -f build-install.xml" to fetch and install dependencies
- run "ant antunit" to run unit tests
- run "ant metadata" to generate JHOVE metadata for the three test tiff files

