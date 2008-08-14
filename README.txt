rails_framework_diff
    by Brian Doll
    http://emphaticsolutions.com

== DESCRIPTION:
"It's amazing how hard it is to find problems when caused by developers 
incorrectly modifying framework-generated files."
 	-- Chad Fowler
    http://twitter.com/chadfowler/statuses/885401839

"i've always wanted to write a rake task to diff framework-generated files 
against their generated default for that very reason"
	-- Brian Doll
	http://twitter.com/briandoll/statuses/885448580

"I would install that gem/plugin if you released it."
	-- Chad Fowler
	http://twitter.com/chadfowler/statuses/885554743

Here you go, Chad!


== FEATURES/PROBLEMS:
See @DESCRIPTION for details on the problem.

The solution is simple, although not very elegant.  The _rails projectname_ command
builds the shell of a rails project with the intended directory structure and assorted files.
Here, we're simply using a diff tool against each of the framework generated files and displaying
the output.  Surely some of the differences that are detected are intentional and correct.  This
tool makes it easy to see what changed, and makes no judgement on the correctness of those changes.


== REQUIREMENTS:
* RubyGems
* diff available in your path
* A rails app you'd like to diff against the framework generated defaults

== INSTALL:

* sudo gem install rails_framework_diff


== ISSUES:
Some framework generated files include some erb syntax which is parsed during generation.  This tool
does not currently deal with that case, so those lines will appear as different.  Examples include
the rails config :session_key, etc.


== USAGE:
To use, make sure that the bin files of installed gems (this one, especially) are accessible via your $PATH
> rails_framework_diff project_name [rails version]
  project_name:  a relative path to the rails project to diff
  rails version: define only to diff against a different version of rails than is specified by the project

== LICENSE:

(The MIT License)

Copyright (c) 2008 Brian Doll

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
