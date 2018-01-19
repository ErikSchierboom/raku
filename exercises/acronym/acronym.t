#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use Acronym;
plan 6;

my Version:D $version = v2;

if Acronym.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nAcronym is {Acronym.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

my $c-data = from-json $=pod.pop.contents;

for $c-data<cases>»<cases>».Array.flat {
  is abbreviate(.<input><phrase>), |.<expected description>;
}

=head2 Canonical Data
=begin code

{
  "exercise": "acronym",
  "version": "1.2.0",
  "cases": [
    {
      "description": "Abbreviate a phrase",
      "cases": [
        {
          "description": "basic",
          "property": "abbreviate",
          "input": {
            "phrase": "Portable Network Graphics"
          },
          "expected": "PNG"
        },
        {
          "description": "lowercase words",
          "property": "abbreviate",
          "input": {
            "phrase": "Ruby on Rails"
          },
          "expected": "ROR"
        },
        {
          "description": "punctuation",
          "property": "abbreviate",
          "input": {
            "phrase": "First In, First Out"
          },
          "expected": "FIFO"
        },
        {
          "description": "all caps words",
          "property": "abbreviate",
          "input": {
            "phrase": "PHP: Hypertext Preprocessor"
          },
          "expected": "PHP"
        },
        {
          "description": "non-acronym all caps word",
          "property": "abbreviate",
          "input": {
            "phrase": "GNU Image Manipulation Program"
          },
          "expected": "GIMP"
        },
        {
          "description": "hyphenated",
          "property": "abbreviate",
          "input": {
            "phrase": "Complementary metal-oxide semiconductor"
          },
          "expected": "CMOS"
        }
      ]
    }
  ]
}

=end code
