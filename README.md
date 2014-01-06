E2DCX
=====
Creates a DataCite XML file from an EML file for DataCite Metadata Store.
The resulting XML will respect the [DataCite Metadata Schema 3.0](http://schema.datacite.org/meta/kernel-3/metadata.xsd).

What you need
=============
 * An assigned DOI prefix, see [DataCite Metadata Store](https://mds.datacite.org/)
 * A XSLT 2.0 processor, [Saxon](http://saxon.sourceforge.net/#F9.4HE) is recommended

How it works
============
For the moment, all the data that can't be found in the EML are taken from a file called config.xml.
You need to update this file with your own information in order to generate the right XML file.

Usage
===== 
 ```
 java -cp saxon9he.jar net.sf.saxon.Transform -t -s:YOUR_INPUT_FILE.eml -xsl:dataCite.xsl -o:YOUR_OUTPUT_FILE.xml
 ```