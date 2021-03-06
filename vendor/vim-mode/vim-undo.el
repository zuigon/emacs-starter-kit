;;; vim-undo.el

;; Copyright (C) 2009 Frank Fischer
;; 
;; Version: 0.0.1
;; Keywords: emulations
;; Human-Keywords: vim, emacs
;; Authors: Frank Fischer <frank.fischer@mathematik.tu-chemnitz.de>,
;; Maintainer: Frank Fischer <frank.fischer@mathematik.tu-chemnitz.de>,
;; License: GPLv2 or later, as described below under "License"

;; Description:

;; Before the execution of an editing command, the calling function
;; should save the current head of buffer-undo-list.  When the
;; editing-command has finished, the calling function should use
;; vim:connect-undos to connect the changes made during editing to one
;; single undo-block.
;;
;; Insert-mode has a special handling: when activated, it stores the
;; current head of buffer-undo-list in vim:last-insert-undo and used
;; this pointer to connect all editing actions during insert-mode to
;; one undo-block when insert-mode is deactivated.  If a function
;; activates insert-mode it may modify vim:last-insert-undo to an
;; apropriate value (see vim:execute-mapping for an example).

(provide 'vim-undo)

(require 'redo nil t)

(defvar vim:last-undo)

;; undo stuff
(defun vim:connect-undos (last-undo)
  (labels
      ((find-mark (lst)
                  (while (not (or (null lst)
                                  (eq lst last-undo)))
                    (setq lst (cdr lst)))
                  (not (null lst))))
                   
    ;; ensure last-undo is still in the undo list
    (when (and last-undo
               (not (eq last-undo buffer-undo-list))
               (find-mark buffer-undo-list))
      
      ;; add the end-of-command mark if not already there
      (unless (null (car buffer-undo-list))
        (push nil buffer-undo-list))

      ;; remove all nils until the mark
      (let ((lst buffer-undo-list))
        (while (and lst
                    (not (eq (cdr lst) last-undo)))
          (if (null (cadr lst))
              (setcdr lst (cddr lst))
            (setq lst (cdr lst))))))))


(vim:defcmd vim:cmd-undo (count nonrepeatable)
  (setq vim:last-undo nil)
  (dotimes (i (or count 1))
    (undo)))
    
(vim:defcmd vim:cmd-redo (count nonrepeatable)
  (setq vim:last-undo nil)
  (redo (or count 1)))
    
  
  
  
