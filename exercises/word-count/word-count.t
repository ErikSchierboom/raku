#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use WordCount;
plan 11;

my Version:D $version = v3;

if WordCount.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nWordCount is {WordCount.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

my $c-data = from-json $=pod.pop.contents;
is-deeply (% = .<input>.&count-words), |.<expected description> for @($c-data<cases>);

=head2 Canonical Data
=begin code

{
  "exercise": "word-count",
  "version": "1.0.0",
  "comments": [
    "For each word in the input, count the number of times it appears in the",
    "entire sentence."
  ],
  "cases": [
    {
      "description": "count one word",
      "property": "countwords",
      "input": "word",
      "expected": {
        "word": 1
      }
    },
    {
      "description": "count one of each word",
      "property": "countwords",
      "input": "one of each",
      "expected": {
        "one": 1,
        "of": 1,
        "each": 1
      }
    },
    {
      "description": "multiple occurrences of a word",
      "property": "countwords",
      "input": "one fish two fish red fish blue fish",
      "expected": {
        "one": 1,
        "fish": 4,
        "two": 1,
        "red": 1,
        "blue": 1
      }
    },
    {
      "description": "handles cramped lists",
      "property": "countwords",
      "input": "one,two,three",
      "expected": {
        "one": 1,
        "two": 1,
        "three": 1
      }
    },
    {
      "description": "handles expanded lists",
      "property": "countwords",
      "input": "one,\ntwo,\nthree",
      "expected": {
        "one": 1,
        "two": 1,
        "three": 1
      }
    },
    {
      "description": "ignore punctuation",
      "property": "countwords",
      "input": "car: carpet as java: javascript!!&@$%^&",
      "expected": {
        "car": 1,
        "carpet": 1,
        "as": 1,
        "java": 1,
        "javascript": 1
      }
    },
    {
      "description": "include numbers",
      "property": "countwords",
      "input": "testing, 1, 2 testing",
      "expected": {
        "testing": 2,
        "1": 1,
        "2": 1
      }
    },
    {
      "description": "normalize case",
      "property": "countwords",
      "input": "go Go GO Stop stop",
      "expected": {
        "go": 3,
        "stop": 2
      }
    },
    {
      "description": "with apostrophes",
      "property": "countwords",
      "input": "First: don't laugh. Then: don't cry.",
      "expected": {
        "first": 1,
        "don't": 2,
        "laugh": 1,
        "then": 1,
        "cry": 1
      }
    },
    {
      "description": "with quotations",
      "property": "countwords",
      "input": "Joe can't tell between 'large' and large.",
      "expected": {
        "joe": 1,
        "can't": 1,
        "tell": 1,
        "between": 1,
        "large": 2,
        "and": 1
      }
    },
    {
      "description": "multiple spaces not detected as a word",
      "property": "countwords",
      "input": " multiple   whitespaces",
      "expected": {
        "multiple": 1,
        "whitespaces": 1
      }
    }
  ]
}

=end code
