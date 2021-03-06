;;; vim-scroll.el

;; Copyright (C) 2009 Frank Fischer
;; 
;; Version: 0.0.1
;; Keywords: emulations
;; Human-Keywords: vim, emacs
;; Authors: Frank Fischer <frank.fischer@mathematik.tu-chemnitz.de>,
;; Maintainer: Frank Fischer <frank.fischer@mathematik.tu-chemnitz.de>,
;; License: GPLv2 or later, as described below under "License"

;; Description:

;; This file contains implementations for the scrolling.  Scroll
;; operations are usually just simple commands and should not be
;; repeatable but should keep visual mode.


(provide 'vim-scroll)

(require 'windmove nil t)

(defun vim:num-visible-lines ()
  "Returns the number of currently visible lines."
  (- (window-height) 1))

(defun vim:max-scroll-up ()
  "Returns the maximal number of lines that can be scrolled up."
  (1- (line-number-at-pos (window-start))))

(defun vim:max-scroll-down ()
  "Returns the maximal number of lines that can be scrolled down."
  (if (pos-visible-in-window-p (window-end))
      0
      (1+ (- (line-number-at-pos (point-max))
             (line-number-at-pos (window-end))))))

(vim:defcmd vim:scroll-line-up (count nonrepeatable keep-visual)
  "Scrolls the window `count' lines upwards."
  (vim:use-last-column)
  (scroll-down (or count 1)))


(vim:defcmd vim:scroll-line-down (count nonrepeatable keep-visual)
  "Scrolls the window `count' lines downwards."
  (vim:use-last-column)
  (scroll-up (or count 1)))


(vim:defcmd vim:scroll-up (count nonrepeatable keep-visual)
  "Scrolls the window and the cursor `count' lines upwards, default half of the screen."
  (vim:use-last-column)
  (let ((p (point))
        (c (or count (/ (vim:num-visible-lines) 2))))
    (save-excursion
      (scroll-down (min (vim:max-scroll-up) c)))
    (forward-line (- c))
    (when (= (line-number-at-pos p)
             (line-number-at-pos (point)))
      (ding))))


(vim:defcmd vim:scroll-down (count nonrepeatable keep-visual)
  "Scrolls the window and the cursor `count' lines downwards, default half of the screen."
  (vim:use-last-column)
  (let ((p (point))
        (c (or count (/ (vim:num-visible-lines) 2))))
    (save-excursion
      (scroll-up (min (vim:max-scroll-down) c)))
    (forward-line c)
    (when (= (line-number-at-pos p)
             (line-number-at-pos (point)))
      (ding))))


(vim:defcmd vim:scroll-page-up (count nonrepeatable keep-visual)
  "Scrolls the window `count' pages upwards."
  (vim:use-last-column)
  (condition-case nil
      (dotimes (i (or count 1))
        (scroll-down nil))
    (error (goto-char (point-min)))))


(vim:defcmd vim:scroll-page-down (count nonrepeatable keep-visual)
  "Scrolls the window `count' pages upwards."
  (vim:use-last-column)
  (condition-case nil
      (dotimes (i (or count 1))
        (scroll-up nil))
    (error (goto-char (point-max)))))


(vim:defcmd vim:scroll-line-to-top (count nonrepeatable keep-visual)
  "Scrolls line number `count' (or the cursor line) to the top of the window."            
  (vim:use-last-column)
  (goto-line (or count (line-number-at-pos (point))))
  (recenter 0))


(vim:defcmd vim:scroll-line-to-center (count nonrepeatable keep-visual)
  "Scrolls line number `count' (or the cursor line) to the center of the window."            
  (vim:use-last-column)
  (goto-line (or count (line-number-at-pos (point))))
  (recenter nil))


(vim:defcmd vim:scroll-line-to-bottom (count nonrepeatable keep-visual)
  "Scrolls line number `count' (or the cursor line) to the bottom of the window."            
  (vim:use-last-column)
  (goto-line (or count (line-number-at-pos (point))))
  (recenter -1))


(vim:defcmd vim:scroll-bottom-line-to-top (count nonrepeatable keep-visual)
  "Scrolls the line right below the window or line `count' to the top of the window."
  (if count
      (goto-line count)
    (goto-char (window-end)))
  (recenter 0)
  (goto-char (vim:motion-first-non-blank)))


(vim:defcmd vim:scroll-top-line-to-bottom (count nonrepeatable keep-visual)
  "Scrolls the line right below the window or line `count' to the top of the window."
  (if count
      (goto-line count)
    (goto-char (max (1- (window-start)) (point-min))))
  (recenter -1)
  (goto-char (window-start))
  (recenter -1)
  (goto-char (vim:motion-first-non-blank)))



