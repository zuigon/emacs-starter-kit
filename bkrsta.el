;; DESCRIPTION: bkrsta settings

(add-to-list 'load-path (concat dotfiles-dir "/vendor"))

;;; Environment variables
(setenv "PATH"  "/usr/local/git/bin:/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/sw/bin:/usr/local/git/bin:/usr/local/mysql-5.1.32-osx10.5-x86/bin/:~/.gem/ruby/1.8/bin")


(load "color-custom/color-theme-helvetica.el")
(load "color-custom/color-theme-ir-black.el")
(load "color-custom/color-theme-tango2.el")
(load "color-custom/color-theme-twilight.el")
(load "color-custom/color-theme-vividchalk.el")
(load "color-custom/custom-color-themes.el")
(load "color-custom/color-theme-railscasts.el")


;; Save backups in one place
;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
  (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "#" (file-name-nondirectory buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Save after a certain amount of time.
(setq auto-save-timeout 1800)
;;
;; Change backup behavior to save in a specified directory
(setq backup-directory-alist '(("." . "~/.emacs.d/saves/"))
 backup-by-copying      t
 version-control        t
 delete-old-versions    t
 kept-new-versions      6
 kept-old-versions      2
)

;; Keep bookmarks in the load path
(setq bookmark-default-file "~/.emacs.d/emacs-bookmarks")


;; Speedbar settings
(require 'speedbar)
;; Additional extensions we are interested in
(speedbar-add-supported-extension
  '("PKGBUILD" ".txt" ".org" ".pdf" ".css" ".rb" ".py"
    ".php" ".conf" ".patch" ".diff" ".lua" ".sh")
)


;; Magit
(require 'magit)

;; Snippets
(add-to-list 'load-path (concat dotfiles-dir "/vendor/yasnippet.el"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "/vendor/yasnippet.el/snippets"))

;; Commands
(require 'unbound)

;; Minor Modes
(add-to-list 'load-path (concat dotfiles-dir "/vendor/textmate.el"))
(require 'textmate)
(textmate-mode)
(require 'whitespace)

;; Major Modes

;; Javascript
;; TODO javascript-indent-level 2

;; Rinari
(add-to-list 'load-path (concat dotfiles-dir "/vendor/jump.el"))
(add-to-list 'load-path (concat dotfiles-dir "/vendor/rinari"))
(require 'rinari)
(define-key rinari-minor-mode-map [(control meta shift down)] 'rinari-find-rspec)
(define-key rinari-minor-mode-map [(control meta shift left)] 'rinari-find-controller)
(define-key rinari-minor-mode-map [(control meta shift up)] 'rinari-find-model)
(define-key rinari-minor-mode-map [(control meta shift right)] 'rinari-find-view)

(autoload 'applescript-mode "applescript-mode" "major mode for editing AppleScript source." t)
(setq auto-mode-alist
      (cons '("\\.applescript$" . applescript-mode) auto-mode-alist))

;; textile-mode
(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))

;; markdown-mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

;; haml-mode
(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(define-key haml-mode-map [(control meta down)] 'haml-forward-sexp)
(define-key haml-mode-map [(control meta up)] 'haml-backward-sexp)
(define-key haml-mode-map [(control meta left)] 'haml-up-list)
(define-key haml-mode-map [(control meta right)] 'haml-down-list)

;; sass-mode
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.sake\\'" . ruby-mode))

;; csharp-mode
(autoload 'csharp-mode "csharp-mode.el"
  "Major mode for C#" t)
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))


;; XCODE
(require 'objc-c-mode)
(require 'xcode)
(define-key objc-mode-map [(meta r)] 'xcode-compile)
(define-key objc-mode-map [(meta K)] 'xcode-clean)
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  [(meta O)] 'ff-find-other-file)))
(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key (kbd "C-c <right>") 'hs-show-block)
            (local-set-key (kbd "C-c <left>")  'hs-hide-block)
            (local-set-key (kbd "C-c <up>")    'hs-hide-all)
            (local-set-key (kbd "C-c <down>")  'hs-show-all)
            (hs-minor-mode t)))         ; Hide and show blocks


;{{{ OrgMode
;; Initialization
(add-to-list 'load-path "~/.emacs.d/vendor/org-mode/lisp")
(require 'org-install)
;;
;; Extended mouse functionality
(load "~/.emacs.d/vendor/org-mode/lisp/org-mouse.el")

;; Settings
(setq org-directory "~/.org/")
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; Misc
(setq org-log-done t)
(setq org-completion-use-ido t)
(setq org-return-follows-link t)
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))

;; Pass mailto links to Alpine instead of browse-url
(setq org-link-mailto-program 
 '(shell-command "open -a /Applications/Mail.app/ 'mailto:%a?Subject=%s'")
)

;; Files that are included in org-mode agenda
(setq org-agenda-files
 (list "~/.org/index.org" "~/.org/personal.org" "~/.org/computers.org")
)
;}}}


;{{{ Remember mode
;   - connected with org-mode
;
;; Initialization
(add-to-list 'load-path (concat dotfiles-dir "/vendor/remember"))
(require 'remember)

;; Connect with org-mode
(org-remember-insinuate)
;;
;; Notes file
(setq org-default-notes-file (concat org-directory "/notes.org"))
;
;; Templates for Notes
(setq org-remember-templates
 '(("Note" ?n "* NOTE %?\n%i\n%a" "~/.org/notes.org" "Notes")
   ("Download" ?d "* DL %?\n%i\n%a" "~/.org/notes.org" "Download")
   ("Music" ?m "* MUSIC %?\n%i\n%a" "~/.org/notes.org" "Music")
   ("Idea" ?i "* %^{Title}\n%i\n%a" "~/.org/notes.org" "Ideje")
   ("Clipboard" ?c "* %^{Description} %T\n%x" "~/.org/notes.org" "Clipboard"))
)

;; Remember frames
;;   - $ emacsclient -e '(make-remember-frame)'
;;
;; Org-remember splits windows, force it to a single window
(add-hook 'remember-mode-hook  'delete-other-windows)

;; Automatic closing of remember frames
(defadvice remember-finalize (after delete-remember-frame activate)
  "Advise remember-finalize to close the frame if it is the remember frame"
  (if (equal "*Remember*" (frame-parameter nil 'name))
    (delete-frame))
)
(defadvice remember-destroy (after delete-remember-frame activate)
  "Advise remember-destroy to close the frame if it is the remember frame"
  (if (equal "*Remember*" (frame-parameter nil 'name))
    (delete-frame))
)

;; Initialization of remember frames
(defun make-remember-frame ()
  "Create a new frame and run org-remember"
  (interactive)  
  (make-frame '((name . "*Remember*") (width . 80) (height . 10)))
  (select-frame-by-name "*Remember*")
  (org-remember)
)
;}}}


;{{{ Crontab mode
;    - http://www.mahalito.net/~harley/elisp/crontab-mode.el
;
(autoload 'crontab-mode "~/.emacs.d/crontab-mode.el" "Major mode for editing the crontab" t)
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."   . crontab-mode))
;}}}

;{{{ Post mode
;    - http://post-mode.sourceforge.net/
;
(autoload 'post-mode "~/.emacs.d/post.el" "Major mode for editing e-mail and journal articles" t)
(add-to-list 'auto-mode-alist 
  '("\\.*mutt-*\\|\\.*pico.*\\|.article\\|\\.*200\\(T\\)?\\|\\.followup" . post-mode))
;}}}



;; Font
(set-face-font 'default "-apple-monaco-medium-r-normal--14-0-72-72-m-0-iso10646-1")

;; Color Themes
(add-to-list 'load-path (concat dotfiles-dir "/vendor/color-theme"))
(require 'color-theme)
; (color-theme-initialize)

(color-theme-twilight)
; (color-theme-zenburn)


;; Saveplace
;;   - places cursor in the last place you edited file
(require 'saveplace)
(setq-default save-place t)
;; Keep places in the load path
(setq save-place-file "~/.emacs.d/emacs-places")

;; Uniquify
;;   - makes buffer names unique
(require 'uniquify)
(setq uniquify-separator ":")
(setq uniquify-buffer-name-style 'post-forward)

;; Auto Compression
;;   - edit files in compressed archives
(auto-compression-mode 1)


;{{{ Reload or edit .emacs on the fly
;    - key bindings defined below
;
(defun aic-reload-dot-emacs ()
  "Reload user configuration from .emacs"
  (interactive)
  ;; Fails on killing the Messages buffer, workaround:
  (get-buffer-create "*Messages*")
  (load-file "~/.emacs.d/init.el")
)
(defun aic-edit-dot-emacs ()
  "Edit user configuration in .emacs"
  (interactive)
  (find-file "~/.emacs.d/init.el")
)
;}}}


;; Other modes
(load "pastie.el")
(load "twit.el")
(load "vendor/itunes-osx.el")
(load "vendor/ascii-table.el")
(add-to-list 'load-path (concat dotfiles-dir "/vendor/org-mode/lisp"))
(load "vendor/org-mode/lisp/org.el")

; (require 'vimpulse)

(setq gdb-many-windows t)



(require 'anything)

(load-file (concat dotfiles-dir "/vendor/cedet/common/cedet.el"))

(add-to-list 'load-path (concat dotfiles-dir "/vendor/ecb-snap"))
(require 'ecb-autoloads)
(setq ecb-tip-of-the-day nil) ; Disable tip of the day

;; Linum
(require 'linum)
;;(setq linum-format "%d | ")
;;(global-linum-mode) ;; - breaks org-mode

;; W3
(add-to-list 'load-path (concat dotfiles-dir "/vendor/w3/lisp"))
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(require 'w3)



;; Tab size
(setq default-tab-width 4)

;; Functions

(require 'pointback)

(require 'line-num)

;; Full screen toggle
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                         'fullboth)))
(global-set-key (kbd "M-n") 'toggle-fullscreen)


;; Keyboard

;; Split Windows
(global-set-key [f6] 'split-window-horizontally)
(global-set-key [f7] 'split-window-vertically)
(global-set-key [f8] 'delete-window)

;; Some Mac-friendly key counterparts
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-z") 'undo)

;; Keyboard Overrides
(define-key textile-mode-map (kbd "M-s") 'save-buffer)
(define-key text-mode-map (kbd "M-s") 'save-buffer)

(global-set-key [(meta up)] 'beginning-of-buffer)
(global-set-key [(meta down)] 'end-of-buffer)

(global-set-key [(meta shift right)] 'ido-switch-buffer)
(global-set-key [(meta shift up)] 'recentf-ido-find-file)
(global-set-key [(meta shift down)] 'ido-find-file)
(global-set-key [(meta shift left)] 'magit-status)

; (global-set-key [(meta H)] 'delete-other-windows)

(global-set-key [(meta D)] 'backward-kill-word) ;; (meta d) is opposite

(global-set-key [(meta N)] 'cleanup-buffer)

(global-set-key [(control \])] 'indent-rigidly)


;; IJKL Movement
;; Single char cursor movement

; (global-set-key (kbd "C-č") 'backward-char)
; (global-set-key (kbd "C-ž") 'forward-char)
; (global-set-key (kbd "C-š") 'previous-line)
; (global-set-key (kbd "C-ć") 'next-line)


;; Other

(prefer-coding-system 'utf-8)

(server-start)


;; Save layout on exit
(desktop-save-mode 1)


(toggle-fullscreen)
