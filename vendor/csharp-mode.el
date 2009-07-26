<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: csharp-mode.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=csharp-mode.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: csharp-mode.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=csharp-mode.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for csharp-mode.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=csharp-mode.el" /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<br /><span class="specialdays">Liberia, National Day, Maldives, National Day</span><h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22csharp-mode.el%22">csharp-mode.el</a></h1></div><div class="wrapper"><div class="content browse"><p><a href="http://www.emacswiki.org/emacs/download/csharp-mode.el">Download</a></p><pre class="code"><span class="linecomment">;;; csharp-mode.el --- C# mode derived mode</span>

<span class="linecomment">;; Author:     2005Dylan R. E. Moonfire</span>
<span class="linecomment">;; Maintainer: Dylan R. E. Moonfire &lt;contact@mfgames.com&gt;</span>
<span class="linecomment">;; Created:    Feburary 2005</span>
<span class="linecomment">;; Modified:   September 2007</span>
<span class="linecomment">;; Version:    0.7.0</span>
<span class="linecomment">;; Keywords:   c# languages oop</span>

<span class="linecomment">;; This program is free software; you can redistribute it and/or modify</span>
<span class="linecomment">;; it under the terms of the GNU General Public License as published by</span>
<span class="linecomment">;; the Free Software Foundation; either version 2 of the License, or</span>
<span class="linecomment">;; (at your option) any later version.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This program is distributed in the hope that it will be useful,</span>
<span class="linecomment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>
<span class="linecomment">;; GNU General Public License for more details.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with this program; see the file COPYING.  If not, write to</span>
<span class="linecomment">;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,</span>
<span class="linecomment">;; Boston, MA 02111-1307, USA.</span>

<span class="linecomment">;;; Commentary:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;    This is a separate mode to implement the C# constructs and</span>
<span class="linecomment">;;    font-locking. It is based on the java-mode example from cc-mode.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;    Note: The interface used in this file requires CC Mode 5.30 or</span>
<span class="linecomment">;;    later.</span>

<span class="linecomment">;;; Bugs:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   Literal strings @"" do not fontify correctly.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   Method names are not fontified if you have an attribute before it.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   This code doesn't seem to work when you compile it, then</span>
<span class="linecomment">;;   load/require in the emacs file. You will get an error (error</span>
<span class="linecomment">;;   "`c-lang-defconst' must be used in a file") which happens because</span>
<span class="linecomment">;;   cc-mode doesn't think it is in a buffer while loading directly</span>
<span class="linecomment">;;   from the init. However, if you call it based on a file extension,</span>
<span class="linecomment">;;   it works properly. Interestingly enough, this doesn't happen if</span>
<span class="linecomment">;;   you don't byte-compile cc-mode.</span>

<span class="linecomment">;;; .emacs (don't put in (require 'csharp-mode))</span>
<span class="linecomment">;; (autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)</span>
<span class="linecomment">;; (setq auto-mode-alist</span>
<span class="linecomment">;;    (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))</span>

<span class="linecomment">;;; Versions:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;    0.1.0 - Initial release.</span>
<span class="linecomment">;;    0.2.0 - Fixed the identification on the "enum" keyword.</span>
<span class="linecomment">;;          - Fixed the font-lock on the "base" keyword</span>
<span class="linecomment">;;    0.3.0 - Added a regex to fontify attributes. It isn't the</span>
<span class="linecomment">;;            the best method, but it handles single-like attributes</span>
<span class="linecomment">;;            well.</span>
<span class="linecomment">;;          - Got "super" not to fontify as a keyword.</span>
<span class="linecomment">;;          - Got extending classes and interfaces to fontify as something.</span>
<span class="linecomment">;;    0.4.0 - Removed the attribute matching because it broke more than</span>
<span class="linecomment">;;            it fixed.</span>
<span class="linecomment">;;          - Corrected a bug with namespace not being properly identified</span>
<span class="linecomment">;;            and treating the class level as an inner object, which screwed</span>
<span class="linecomment">;;            up formatting.</span>
<span class="linecomment">;;          - Added "partial" to the keywords.</span>
<span class="linecomment">;;    0.5.0 - Found bugs with compiled cc-mode and loading from init files.</span>
<span class="linecomment">;;          - Updated the eval-when-compile to code to let the mode be</span>
<span class="linecomment">;;            compiled.</span>
<span class="linecomment">;;    0.6.0 - Added the c-filter-ops patch for 5.31.1 which made that</span>
<span class="linecomment">;;            function in cc-langs.el unavailable.</span>
<span class="linecomment">;;          - Added a csharp-lineup-region for indention #region and</span>
<span class="linecomment">;;            #endregion block differently.</span>
<span class="linecomment">;;    0.7.0 - Added autoload so update-directory-autoloads words</span>
<span class="linecomment">;;            (Thank you, Nikolaj Schumacher)</span>
<span class="linecomment">;;          - Fontified the entire #region and #endregion lines.</span>
<span class="linecomment">;;          - Initial work to get get, set, add, remove font-locked.</span>

<span class="linecomment">;; This is a copy of the function in cc-mode which is used to handle</span>
<span class="linecomment">;; the eval-when-compile which is needed during other times.</span>
(defun c-filter-ops (ops opgroup-filter op-filter &optional xlate)
  <span class="linecomment">;; See cc-langs.el, a direct copy.</span>
  (unless (listp (car-safe ops))
    (setq ops (list ops)))
  (cond ((eq opgroup-filter t)
         (setq opgroup-filter (lambda (opgroup) t)))
        ((not (functionp opgroup-filter))
         (setq opgroup-filter `(lambda (opgroup)
                                 (memq opgroup ',opgroup-filter)))))
  (cond ((eq op-filter t)
         (setq op-filter (lambda (op) t)))
        ((stringp op-filter)
         (setq op-filter `(lambda (op)
                            (string-match ,op-filter op)))))
  (unless xlate
    (setq xlate 'identity))
  (c-with-syntax-table (c-lang-const c-mode-syntax-table)
    (delete-duplicates
     (mapcan (lambda (opgroup)
               (when (if (symbolp (car opgroup))
                         (when (funcall opgroup-filter (car opgroup))
                           (setq opgroup (cdr opgroup))
                           t)
                       t)
                 (mapcan (lambda (op)
                           (when (funcall op-filter op)
                             (let ((res (funcall xlate op)))
                               (if (listp res) res (list res)))))
                         opgroup)))
             ops)
     :test 'equal)))

<span class="linecomment">;; This inserts the bulk of the code.</span>
(require 'cc-mode)

<span class="linecomment">;; These are only required at compile time to get the sources for the</span>
<span class="linecomment">;; language constants.  (The cc-fonts require and the font-lock</span>
<span class="linecomment">;; related constants could additionally be put inside an</span>
<span class="linecomment">;; (eval-after-load "font-lock" ...) but then some trickery is</span>
<span class="linecomment">;; necessary to get them compiled.)</span>
(eval-when-compile
  (let ((load-path
         (if (and (boundp 'byte-compile-dest-file)
                  (stringp byte-compile-dest-file))
             (cons (file-name-directory byte-compile-dest-file) load-path)
           load-path)))
    (load "<span class="quote">cc-mode</span>" nil t)
    (load "<span class="quote">cc-fonts</span>" nil t)
    (load "<span class="quote">cc-langs</span>" nil t)))

(eval-and-compile
  <span class="linecomment">;; Make our mode known to the language constant system.  Use Java</span>
  <span class="linecomment">;; mode as the fallback for the constants we don't change here.</span>
  <span class="linecomment">;; This needs to be done also at compile time since the language</span>
  <span class="linecomment">;; constants are evaluated then.</span>
  (c-add-language 'csharp-mode 'java-mode))

<span class="linecomment">;; Indention: csharp-mode follows normal indention rules except for</span>
<span class="linecomment">;; when indenting the #region and #endregion blocks. This function</span>
<span class="linecomment">;; defines a custom indention to indent the #region blocks as normal</span>
<span class="linecomment">;; text.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; To use this indenting just put the following in your emacs file:</span>
<span class="linecomment">;;   (c-set-offset 'cpp-macro 'csharp-lineup-region)</span>
(defun csharp-lineup-region (langelem)
  "<span class="quote">Indent all #region and #endregion blocks inline with code while
retaining normal column-zero indention for #if and the other
processing blocks.</span>"
  (save-excursion
    (back-to-indentation)
    (if (re-search-forward "<span class="quote">#\\(end\\)?region</span>" (c-point 'eol) [0]) 0  [0])))

<span class="linecomment">;; TODO</span>
<span class="linecomment">;; Defines our constant for finding attributes.</span>
<span class="linecomment">;;(defconst csharp-attribute-regex "\\[\\([XmlType]+\\)(")</span>
<span class="linecomment">;;(defconst csharp-attribute-regex "\\[\\(.\\)")</span>
<span class="linecomment">;; This doesn't work because the string regex happens before this point</span>
<span class="linecomment">;; and getting the font-locking to work before and after is fairly difficult</span>
<span class="linecomment">;;(defconst csharp-attribute-regex</span>
<span class="linecomment">;;  (concat</span>
<span class="linecomment">;;   "\\[[a-zA-Z][ \ta-zA-Z0-9.]+"</span>
<span class="linecomment">;;   "\\((.*\\)?"</span>
<span class="linecomment">;;))</span>

<span class="linecomment">;; Java uses a series of regexes to change the font-lock for class</span>
<span class="linecomment">;; references. The problem comes in because Java uses Pascal (leading</span>
<span class="linecomment">;; space in names, SomeClass) for class and package names, but</span>
<span class="linecomment">;; Camel-casing (initial lowercase, upper case in words,</span>
<span class="linecomment">;; i.e. someVariable) for variables. The notation suggested by EMCA is</span>
<span class="linecomment">;; to use Pasacal notation for everything, except inner variables. So,</span>
<span class="linecomment">;; the regex and formatting actually produces very wrong results.</span>
<span class="linecomment">;;(error (byte-compile-dest-file))</span>
<span class="linecomment">;;(error (c-get-current-file))</span>
(c-lang-defconst c-opt-after-id-concat-key
  csharp (if (c-lang-const c-opt-identifier-concat-key)
             (c-lang-const c-symbol-start)))

(c-lang-defconst c-basic-matchers-before
  csharp `(
           <span class="linecomment">;;;; Font-lock the attributes by searching for the</span>
           <span class="linecomment">;;;; appropriate regex and marking it as TODO.</span>
           <span class="linecomment">;;,`(,(concat "\\(" csharp-attribute-regex "\\)")</span>
           <span class="linecomment">;;   0 font-lock-function-name-face)</span>

           <span class="linecomment">;; Put a warning face on the opener of unclosed strings that</span>
           <span class="linecomment">;; can't span lines.  Later font</span>
           <span class="linecomment">;; lock packages have a `font-lock-syntactic-face-function' for</span>
           <span class="linecomment">;; this, but it doesn't give the control we want since any</span>
           <span class="linecomment">;; fontification done inside the function will be</span>
           <span class="linecomment">;; unconditionally overridden.</span>
           ,(c-make-font-lock-search-function
             <span class="linecomment">;; Match a char before the string starter to make</span>
             <span class="linecomment">;; `c-skip-comments-and-strings' work correctly.</span>
             (concat "<span class="quote">.\\(</span>" c-string-limit-regexp "<span class="quote">\\)</span>")
             '((c-font-lock-invalid-string)))

           <span class="linecomment">;; Fontify keyword constants.</span>
           ,@(when (c-lang-const c-constant-kwds)
               (let ((re (c-make-keywords-re nil
                           (c-lang-const c-constant-kwds))))
                 `((eval . (list ,(concat "<span class="quote">\\&lt;\\(</span>" re "<span class="quote">\\)\\&gt;</span>")
                                 1 c-constant-face-name)))))

           <span class="linecomment">;; Fontify all keywords except the primitive types.</span>
           ,`(,(concat "<span class="quote">\\&lt;</span>" (c-lang-const c-regular-keywords-regexp))
              1 font-lock-keyword-face)

           <span class="linecomment">;; Fontify leading identifiers in fully qualified names like</span>
           <span class="linecomment">;; "Foo.Bar".</span>
           ,@(when (c-lang-const c-opt-identifier-concat-key)
               `((,(byte-compile
                    `(lambda (limit)
                       (while (re-search-forward
                               ,(concat "<span class="quote">\\(\\&lt;</span>" <span class="linecomment">; 1</span>
                                        "<span class="quote">\\(</span>" (c-lang-const c-symbol-key)
                                        "<span class="quote">\\)</span>" <span class="linecomment">; 2</span>
                                        "<span class="quote">[ \t\n\r\f\v]*</span>"
                                        (c-lang-const
                                         c-opt-identifier-concat-key)
                                        "<span class="quote">[ \t\n\r\f\v]*</span>"
                                        "<span class="quote">\\)</span>"
                                        "<span class="quote">\\(</span>"
                                        (c-lang-const
                                         c-opt-after-id-concat-key)
                                        "<span class="quote">\\)</span>")
                               limit t)
                         (unless (progn
                                   (goto-char (match-beginning 0))
                                   (c-skip-comments-and-strings limit))
                           (or (get-text-property (match-beginning 2) 'face)
                               (c-put-font-lock-face (match-beginning 2)
                                                     (match-end 2)
                                                     c-reference-face-name))
                           (goto-char (match-end 1)))))))))
           ))

<span class="linecomment">;; C# does not allow a leading qualifier operator. It also doesn't</span>
<span class="linecomment">;; allow the ".*" construct of Java. So, we redo this regex without</span>
<span class="linecomment">;; the "\\|\\*" regex.</span>
(c-lang-defconst c-identifier-key
  csharp (concat "<span class="quote">\\(</span>" (c-lang-const c-symbol-key) "<span class="quote">\\)</span>" <span class="linecomment">; 1</span>
                 (concat "<span class="quote">\\(</span>"
                         "<span class="quote">[ \t\n\r\f\v]*</span>"
                         (c-lang-const c-opt-identifier-concat-key)
                         "<span class="quote">[ \t\n\r\f\v]*</span>"
                         (concat "<span class="quote">\\(</span>"
                                 "<span class="quote">\\(</span>" (c-lang-const c-symbol-key) "<span class="quote">\\)</span>"
                                 "<span class="quote">\\)</span>")
                         "<span class="quote">\\)*</span>")))

<span class="linecomment">;; C# has a few rules that are slightly different than Java for</span>
<span class="linecomment">;; operators. This also removed the Java's "super" and replaces it</span>
<span class="linecomment">;; with the C#'s "base".</span>
(c-lang-defconst c-operators
  csharp `((prefix "<span class="quote">base</span>")))

<span class="linecomment">;; C#, unlike Java, does use CPP prefixes for the regions and other</span>
<span class="linecomment">;; directives. This matches everything to the end of the line (Closes</span>
<span class="linecomment">;; #76).</span>
(c-lang-defconst c-opt-cpp-prefix
  csharp "<span class="quote">^\\s *#.*</span>")

<span class="linecomment">;; C# uses the following assignment operators</span>
(c-lang-defconst c-assignment-operators
  csharp '("<span class="quote">=</span>" "<span class="quote">*=</span>" "<span class="quote">/=</span>" "<span class="quote">%=</span>" "<span class="quote">+=</span>" "<span class="quote">-=</span>" "<span class="quote">&gt;&gt;=</span>" "<span class="quote">&lt;&lt;=</span>" "<span class="quote">&=</span>" "<span class="quote">^=</span>" "<span class="quote">|=</span>"))

<span class="linecomment">;; This defines the primative types for C#</span>
(c-lang-defconst c-primitive-type-kwds
  <span class="linecomment">;; ECMA-344, S8</span>
  csharp '("<span class="quote">object</span>" "<span class="quote">string</span>" "<span class="quote">sbyte</span>" "<span class="quote">short</span>" "<span class="quote">int</span>" "<span class="quote">long</span>" "<span class="quote">byte</span>"
           "<span class="quote">ushort</span>" "<span class="quote">uint</span>" "<span class="quote">ulong</span>" "<span class="quote">float</span>" "<span class="quote">double</span>" "<span class="quote">bool</span>" "<span class="quote">char</span>"
           "<span class="quote">decimal</span>" "<span class="quote">void</span>"))

<span class="linecomment">;; The keywords that define that the following is a type, such as a</span>
<span class="linecomment">;; class definition.</span>
(c-lang-defconst c-type-prefix-kwds
  <span class="linecomment">;; ECMA-344, S?</span>
  csharp '("<span class="quote">class</span>" "<span class="quote">interface</span>" "<span class="quote">enum</span>" "<span class="quote">struct</span>"))

<span class="linecomment">;; Type modifier keywords. They appear anywhere in types, but modifiy</span>
<span class="linecomment">;; instead create one.</span>
(c-lang-defconst c-type-modifier-kwds
  <span class="linecomment">;; EMCA-344, S?</span>
  csharp '("<span class="quote">readonly</span>" "<span class="quote">const</span>"))

<span class="linecomment">;; Structures that are similiar to classes.</span>
(c-lang-defconst c-class-decl-kwds
  <span class="linecomment">;; EMCA-344, S?</span>
  csharp '("<span class="quote">class</span>" "<span class="quote">interface</span>"))

<span class="linecomment">;; The various modifiers used for class and method descriptions.</span>
(c-lang-defconst c-modifier-kwds
  csharp '("<span class="quote">public</span>" "<span class="quote">partial</span>" "<span class="quote">private</span>" "<span class="quote">const</span>" "<span class="quote">abstract</span>"
           "<span class="quote">protected</span>" "<span class="quote">ref</span>" "<span class="quote">out</span>" "<span class="quote">static</span>" "<span class="quote">virtual</span>"
           "<span class="quote">override</span>" "<span class="quote">params</span>" "<span class="quote">internal</span>"))

<span class="linecomment">;; We don't use the protection level stuff because it breaks the</span>
<span class="linecomment">;; method indenting. Not sure why, though.</span>
(c-lang-defconst c-protection-kwds
  csharp nil)

<span class="linecomment">;; Define the keywords that can have something following after them.</span>
(c-lang-defconst c-type-list-kwds
  csharp '("<span class="quote">struct</span>" "<span class="quote">class</span>" "<span class="quote">interface</span>" "<span class="quote">is</span>" "<span class="quote">as</span>"
           "<span class="quote">delegate</span>" "<span class="quote">event</span>" "<span class="quote">set</span>" "<span class="quote">get</span>" "<span class="quote">add</span>" "<span class="quote">remove</span>"))

<span class="linecomment">;; This allows the classes after the : in the class declartion to be</span>
<span class="linecomment">;; fontified.</span>
(c-lang-defconst c-typeless-decl-kwds
  csharp '("<span class="quote">:</span>"))

<span class="linecomment">;; Sets up the enum to handle the list properly</span>
(c-lang-defconst c-brace-list-decl-kwds
  csharp '("<span class="quote">enum</span>"))

<span class="linecomment">;; We need to remove Java's package keyword</span>
(c-lang-defconst c-ref-list-kwds
  csharp '("<span class="quote">using</span>" "<span class="quote">namespace</span>"))

<span class="linecomment">;; Follow-on blocks that don't require a brace</span>
(c-lang-defconst c-block-stmt-2-kwds
  csharp '("<span class="quote">for</span>" "<span class="quote">if</span>" "<span class="quote">switch</span>" "<span class="quote">while</span>" "<span class="quote">catch</span>" "<span class="quote">foreach</span>"
           "<span class="quote">checked</span>" "<span class="quote">unchecked</span>" "<span class="quote">lock</span>"))

<span class="linecomment">;; Statements that break out of braces</span>
(c-lang-defconst c-simple-stmt-kwds
  csharp '("<span class="quote">return</span>" "<span class="quote">continue</span>" "<span class="quote">break</span>" "<span class="quote">throw</span>" "<span class="quote">goto</span>"))

<span class="linecomment">;; Statements that allow a label</span>
<span class="linecomment">;; TODO?</span>
(c-lang-defconst c-before-label-kwds
  csharp nil)

<span class="linecomment">;; Constant keywords</span>
(c-lang-defconst c-constant-kwds
  csharp '("<span class="quote">true</span>" "<span class="quote">false</span>" "<span class="quote">null</span>"))

<span class="linecomment">;; Keywords that start "primary expressions."</span>
(c-lang-defconst c-primary-expr-kwds
  csharp '("<span class="quote">this</span>" "<span class="quote">base</span>"))

<span class="linecomment">;; We need to treat namespace as an outer block to class indenting</span>
<span class="linecomment">;; works properly.</span>
(c-lang-defconst c-other-block-decl-kwds
  csharp '("<span class="quote">namespace</span>"))

<span class="linecomment">;; We need to include the "as" for the foreach</span>
(c-lang-defconst c-other-kwds
  csharp '("<span class="quote">in</span>" "<span class="quote">sizeof</span>" "<span class="quote">typeof</span>"))

(c-lang-defconst c-overloadable-operators
  <span class="linecomment">;; EMCA-344, S14.2.1</span>
  csharp '("<span class="quote">+</span>" "<span class="quote">-</span>" "<span class="quote">*</span>" "<span class="quote">/</span>" "<span class="quote">%</span>" "<span class="quote">&</span>" "<span class="quote">|</span>" "<span class="quote">^</span>"
           "<span class="quote">&lt;&lt;</span>" "<span class="quote">&gt;&gt;</span>" "<span class="quote">==</span>" "<span class="quote">!=</span>" "<span class="quote">&gt;</span>" "<span class="quote">&lt;</span>" "<span class="quote">&gt;=</span>" "<span class="quote">&lt;=</span>"))

<span class="linecomment">;; No cpp in this language, but there's still a "sharppragma" directive to</span>
<span class="linecomment">;; fontify.  (The definitions for the extra keywords above are enough</span>
<span class="linecomment">;; to incorporate them into the fontification regexps for types and</span>
<span class="linecomment">;; keywords, so no additional font-lock patterns are required.)</span>
(c-lang-defconst c-cpp-matchers
  csharp (cons
      <span class="linecomment">;; Use the eval form for `font-lock-keywords' to be able to use</span>
      <span class="linecomment">;; the `c-preprocessor-face-name' variable that maps to a</span>
      <span class="linecomment">;; suitable face depending on the (X)Emacs version.</span>
      '(eval . (list "<span class="quote">^\\s *\\(sharppragma\\)\\&gt;\\(.*\\)</span>"
                     (list 1 c-preprocessor-face-name)
                     '(2 font-lock-string-face)))
      <span class="linecomment">;; There are some other things in `c-cpp-matchers' besides the</span>
      <span class="linecomment">;; preprocessor support, so include it.</span>
      (c-lang-const c-cpp-matchers)))

(defcustom csharp-font-lock-extra-types nil
  "<span class="quote">*List of extra types (aside from the type keywords) to recognize in C# mode.
Each list item should be a regexp matching a single identifier.</span>")

(defconst csharp-font-lock-keywords-1 (c-lang-const c-matchers-1 csharp)
  "<span class="quote">Minimal highlighting for C# mode.</span>")

(defconst csharp-font-lock-keywords-2 (c-lang-const c-matchers-2 csharp)
  "<span class="quote">Fast normal highlighting for C# mode.</span>")

(defconst csharp-font-lock-keywords-3 (c-lang-const c-matchers-3 csharp)
  "<span class="quote">Accurate normal highlighting for C# mode.</span>")

(defvar csharp-font-lock-keywords csharp-font-lock-keywords-3
  "<span class="quote">Default expressions to highlight in C# mode.</span>")

(defvar csharp-mode-syntax-table nil
  "<span class="quote">Syntax table used in csharp-mode buffers.</span>")
(or csharp-mode-syntax-table
    (setq csharp-mode-syntax-table
          (funcall (c-lang-const c-make-mode-syntax-table csharp))))

(defvar csharp-mode-abbrev-table nil
  "<span class="quote">Abbreviation table used in csharp-mode buffers.</span>")
(c-define-abbrev-table 'csharp-mode-abbrev-table
  <span class="linecomment">;; Keywords that if they occur first on a line might alter the</span>
  <span class="linecomment">;; syntactic context, and which therefore should trig reindentation</span>
  <span class="linecomment">;; when they are completed.</span>
  '(("<span class="quote">else</span>" "<span class="quote">else</span>" c-electric-continued-statement 0)
    ("<span class="quote">while</span>" "<span class="quote">while</span>" c-electric-continued-statement 0)
    ("<span class="quote">catch</span>" "<span class="quote">catch</span>" c-electric-continued-statement 0)
    ("<span class="quote">finally</span>" "<span class="quote">finally</span>" c-electric-continued-statement 0)))

(defvar csharp-mode-map (let ((map (c-make-inherited-keymap)))
                      <span class="linecomment">;; Add bindings which are only useful for C#</span>
                      map)
  "<span class="quote">Keymap used in csharp-mode buffers.</span>")

<span class="linecomment">;;(easy-menu-define csharp-menu csharp-mode-map "C# Mode Commands"</span>
<span class="linecomment">;;                ;; Can use `csharp' as the language for `c-mode-menu'</span>
<span class="linecomment">;;                ;; since its definition covers any language.  In</span>
<span class="linecomment">;;                ;; this case the language is used to adapt to the</span>
<span class="linecomment">;;                ;; nonexistence of a cpp pass and thus removing some</span>
<span class="linecomment">;;                ;; irrelevant menu alternatives.</span>
<span class="linecomment">;;                (cons "C#" (c-lang-const c-mode-menu csharp)))</span>

<span class="linecomment">;;; Autoload mode trigger</span>
(add-to-list 'auto-mode-alist '("<span class="quote">\\.cs</span>" . csharp-mode))

<span class="linecomment">;; Custom variables</span>
(defcustom csharp-mode-hook nil
  "<span class="quote">*Hook called by `csharp-mode'.</span>"
  :type 'hook
  :group 'c)

<span class="linecomment">;;; The entry point into the mode</span>
<span class="linecomment">;;;###autoload</span>
(defun csharp-mode ()
  "<span class="quote">Major mode for editing C# (pronounced \"see sharp\") code.
This is a simple example of a separate mode derived from CC Mode to
support a language with syntax similar to C/C++/ObjC/Java/IDL/Pike.

The hook `c-mode-common-hook' is run with no args at mode
initialization, then `csharp-mode-hook'.

Key bindings:
\\{csharp-mode-map}</span>"
  (interactive)
  (kill-all-local-variables)
  (c-initialize-cc-mode t)
  (set-syntax-table csharp-mode-syntax-table)
  (setq major-mode 'csharp-mode
        mode-name "<span class="quote">C#</span>"
        local-abbrev-table csharp-mode-abbrev-table
        abbrev-mode t)
  (use-local-map c-mode-map)
  <span class="linecomment">;; `c-init-language-vars' is a macro that is expanded at compile</span>
  <span class="linecomment">;; time to a large `setq' with all the language variables and their</span>
  <span class="linecomment">;; customized values for our language.</span>
  (c-init-language-vars csharp-mode)
  <span class="linecomment">;; `c-common-init' initializes most of the components of a CC Mode</span>
  <span class="linecomment">;; buffer, including setup of the mode menu, font-lock, etc.</span>
  <span class="linecomment">;; There's also a lower level routine `c-basic-common-init' that</span>
  <span class="linecomment">;; only makes the necessary initialization to get the syntactic</span>
  <span class="linecomment">;; analysis and similar things working.</span>
  (c-common-init 'csharp-mode)
  <span class="linecomment">;;(easy-menu-add csharp-menu)</span>
  (run-hooks 'c-mode-common-hook)
  (run-hooks 'csharp-mode-hook)
  (c-update-modeline))

 
(provide 'csharp-mode)

<span class="linecomment">;;; csharp-mode.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=csharp-mode.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=csharp-mode.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=csharp-mode.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=csharp-mode.el">Administration</a></span><span class="time"><br /> Last edited 2009-07-14 09:35 UTC by <a class="author" title="from setnip02.ericsson.net" href="http://www.emacswiki.org/emacs/danielpoe">danielpoe</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
