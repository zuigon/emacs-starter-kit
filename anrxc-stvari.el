;{{{ Custom functions

;{{{ Web search, browser defined earlier
;    - yubnub: a (social) commandline for the web
;
(defun aic-web-search ()
  "Prompt for a web search query in the minibuffer."
  (interactive)
  (let ((search (read-from-minibuffer "Search: ")))
    (browse-url (concat "http://www.yubnub.org/parser/parse?command=" search)))
)
;}}}

;{{{ Timestamp function, for public dotfiles
;    - date-stamp is more appropriate for txt files
;
(defun aic-dotfile-stamp ()
  "Insert time stamp at point."
  (interactive)
  (insert "Updated on: " (format-time-string "%b %e, %H:%M:%S %Z %Y" nil nil))
)
(defun aic-txtfile-stamp ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%d.%m.%Y %H:%M"))
)
;}}}

;{{{ Reload or edit .emacs on the fly
;    - key bindings defined below
;
(defun aic-reload-dot-emacs ()
  "Reload user configuration from .emacs"
  (interactive)
  ;; Fails on killing the Messages buffer, workaround:
  (get-buffer-create "*Messages*")
  (load-file "~/.emacs")
)
(defun aic-edit-dot-emacs ()
  "Edit user configuration in .emacs"
  (interactive)
  (find-file "~/.emacs")
)
;}}}

;{{{ Quick access to ansi-term
;    - key binding defined below
;
(defun aic-visit-ansi-term ()
  "If we are in an *ansi-term*, rename it.
If *ansi-term* is running, switch the buffer.
If there is no *ansi-term*, run it."
  (interactive)
  (if (equal "*ansi-term*" (buffer-name))
      (call-interactively 'rename-buffer)
  (if (get-buffer "*ansi-term*")
      (switch-to-buffer "*ansi-term*")
  (ansi-term "/bin/zsh")))
)
;}}}

;{{{ Quick acces to coding functions
;    - I deal with utf8, latin-2 and cp1250
;
(defun aic-recode-buffer ()
  "Define the coding system for a file."
  (interactive)
  (call-interactively 'set-buffer-file-coding-system)
)
(defun aic-encode-buffer ()
  "Revisit the buffer with another coding system."
  (interactive)
  (call-interactively 'revert-buffer-with-coding-system)
)
;}}}

;{{{ Kill all buffers except scratch
;
(defun aic-nuke-all-buffers ()
  "Kill all buffers, leaving *scratch* only."
  (interactive)
  (mapcar (lambda (x) (kill-buffer x)) (buffer-list))
  (delete-other-windows)
)
;}}}

;{{{ Quick access to OrgMode and the OrgMode agenda
;    - org-mode configuration defined below
;
(defun aic-org-index ()
   "Show the main org file."
   (interactive)
   (find-file "~/.org/index.org")
)
(defun aic-org-agenda ()
  "Show the org-mode agenda."
  (interactive)
  (call-interactively 'org-agenda-list)
)
;}}}

;{{{ Alias some custom functions
;
(defalias 'search-web    'aic-web-search)
(defalias 'stamp         'aic-dotfile-stamp)
(defalias 'date-stamp    'aic-txtfile-stamp)
(defalias 'recode-buffer 'aic-recode-buffer)
(defalias 'encode-buffer 'aic-encode-buffer)
(defalias 'nuke          'aic-nuke-all-buffers)
(defalias 'org           'aic-org-index)
;}}}

;{{{ Shortcut a few commonly used functions
;
(defalias 'cr            'comment-region)
(defalias 'ucr           'uncomment-region)
(defalias 'eb            'eval-buffer)
(defalias 'er            'eval-region)
(defalias 'ee            'eval-expression)
(defalias 'day           'color-theme-vim-colors)
(defalias 'night         'color-theme-zenburn)
(defalias 'fold          'fold-enter-fold-mode-close-all-folds)
;}}}
;}}}


(provide 'anrxc-stvari)
