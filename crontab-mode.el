;Written by Ch. Tronche (http://tronche.com/)
;Copyright by the author. This is unmaintained, no-warranty free software. 
;Please use freely. It is appreciated (but by no means mandatory) to
;acknowledge the author's contribution. Thank you.

;; Major mode for editing a crontab file.

;; put this in your .emacs:
;;
;; (autoload 'crontab-mode "crontab-mode.el" "Major mode for editing your crontab file." t)

(require 'telnet)

(defvar crontab-output-buffer "*Shell Command Output*")
(defvar crontab-buffer-name "crontab")

(defun crontab-mode (remote-crontab)
  "Major mode for editing your crontab file.

When invoked with an argument, prompt for the name of a machine and
edit the crontab file on that machine.

When you've finished, you can type
\\[crontab-send-buffer] (`crontab-send-buffer') to redefine your
crontab file.
"
  (interactive "P")
  (let (buffer-name remote-host crontab-buffer-existed remote-extension crontab-rsh)
    (if remote-crontab
	(setq remote-host (read-string "remote host: ")
	      	    remote-extension (concat "-" remote-host)
		    crontab-rsh (concat remote-shell-program " " remote-host " ")))
    (setq buffer-name (concat "*" crontab-buffer-name remote-extension "*")
	  crontab-buffer-existed (get-buffer buffer-name))
    (switch-to-buffer buffer-name)
    (setq default-directory (expand-file-name "~/"))
    (auto-save-mode auto-save-default)
    (if crontab-buffer-existed
	()
      (shell-command (concat crontab-rsh "crontab -l") t)
      (make-variable-buffer-local 'crontab-put-command)
      (setq crontab-put-command (concat crontab-rsh "crontab"))
      (set-buffer-modified-p ())
      (setq major-mode 'crontab-mode)
      (setq mode-name "Crontab")
      (local-set-key "\C-c\C-c" 'crontab-send-buffer)
      (setq buffer-auto-save-file-name "#" buffer-name "#")
      (run-hooks 'crontab-mode-hook))))

(defun crontab-send-buffer ()
  (interactive)
  (if (or (buffer-modified-p)
	  (yes-or-no-p "crontab not modified, still send it ? "))
      (progn
	(shell-command-on-region (point-min) (point-max) crontab-put-command)
	(let ((errorp))
	  (if (get-buffer crontab-output-buffer)
	      (save-excursion
		(set-buffer crontab-output-buffer)
		(goto-char (point-min))
		(setq errorp (search-forward "error" () t))))
	  (if errorp
	      ()
	    (set-buffer-modified-p ())
	      (bury-buffer))))))
