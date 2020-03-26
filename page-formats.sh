#!/bin/bash

find pdfs -name "*.pdf" -print | while read FILE; do
	echo -n $FILE ""
	pdfinfo $FILE | grep Page\ size
done
