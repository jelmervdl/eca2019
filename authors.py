#!/usr/bin/env python
from __future__ import print_function
import re
import sys

pattern = re.compile(r'^\\insertmydocument\{chapter\}\{(?P<title>.+?)\}\{(?P<authors>.+?)\}\{(?P<file>.+?)\}$')

def parse_authors(authors):
	try:
		rest, last = authors.rsplit(' and ', 1)
		rest = rest.split(', ')
		return [parse_author(author) for author in (rest + [last])]
	except ValueError:
		return [parse_author(authors)]


def parse_author(author):
	try:
		first_name, last_name = author.rsplit(' ', 1)
		return (last_name, first_name)
	except ValueError as e:
		raise Exception('Stupid name: "{}"'.format(author))


def parse_filename(filename):
	match = re.match(r'pdfs/(?P<type>\w+)/(?P<id>\d+)', filename)
	return match.group('type') + '-' + match.group('id')


if __name__ == '__main__':
	for line in sys.stdin:
		line = line.rstrip()
		match = pattern.match(line)
		if match:
			for author in parse_authors(match.group('authors')):
				print(r'\index[authors]{{{0}, {1}}}'.format(*author))
			print(r'\pdfbookmark[chapter]{{{section}}}{{paper-{id}}}'.format(
				section=match.group('title'),
				id=parse_filename(match.group('file'))))
		print(line)
		if match:
			print("")
		
	print(r"Done! Don't forget to enable imakeidx:\n  \usepackage{imakeidx}\n  \makeindex[name=authors,title=Index of Authors,options=-r]", file=sys.stderr)