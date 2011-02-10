;;; $RCSfile: sto-entry.el,v $ $Revision: 1.2 $ $Date: 2002/04/10 15:10:46 $ 

;;; form entries, managing markers defined by sto-entry-marker

(define-key global-map "\C-\\" 'sto-entry-next)
(define-key global-map [?\C-|] 'sto-entry-next-nondeleting)
(define-key global-map "\C-x\C-\\" 'sto-entry-insert)

(defvar sto-entry-marker "&sto:ENTRY;"
  "Marker string for form entries")
(defvar sto-entry-static-marker-open-delim "<"
  "Open delimiter surrounding sto-entry-marker for static markers")
(defvar sto-entry-static-marker-close-delim " />"
  "Close delimiter surrounding sto-entry-marker for static markers")

(defvar sto-entry-next-hook nil 
  "Hooks to evaluate at end of sto-entry-next")

(defvar sto-entry-direction nil
  "Non-nil if most recent sto-entry-next command was in reverse direction")

(defun sto-entry-at-static-marker ()
  "Return non-nil if point is located at end of the string sto-entry-marker 
within a static marker;  return nil otherwise"
;  (interactive)
  (let 
      ((begin (max 1 (- (point) 
			(length sto-entry-marker) 
			(length sto-entry-static-marker-open-delim)))))
    (and (string= (concat sto-entry-static-marker-open-delim sto-entry-marker)
		  (buffer-substring begin (point)))
	 (string= sto-entry-static-marker-close-delim 
		  (buffer-substring (point) 
				    (min (point-max) 
	   (+(point) (length sto-entry-static-marker-close-delim))))))))

(defun sto-entry-next (&optional reverse nondeleting)
  "Jump to next entry location to be filled in a form, and delete entry marker.
With prefix argument REVERSE, jump to first such location in reverse direction.
When used repeatedly, prefix argument changes the direction of the jump, and 
the prior entry marker is restored upon jumping to the next entry marker 
unless NONDELETING is nil.

Usage:  (sto-entry-next &optional REVERSE NONDELETING)" 
  (interactive "P")
  (let ((repeating (or (eq 'sto-entry-next last-command)
		       (eq 'sto-entry-next-nondeleting last-command)))
	(new-reverse ((lambda (x y) (and (or x y) (not (and x y)))) ; xor
		      reverse sto-entry-direction))
	(static (sto-entry-at-static-marker))
	(start (point)))  ; location of beginning of search
    (if repeating
	(setq reverse new-reverse))
    (setq sto-entry-direction reverse)
    ;; reverse, sto-entry-direction are correct for this invocation
    (or 
     (and 
      (if reverse
	  (search-backward sto-entry-marker 0 t (if static 2 1)) 
	t)
      (search-forward sto-entry-marker nil t)
      ;; now located at end of desired marker
      (if (and repeating (not static) nondeleting)
	  (save-excursion
	    (goto-char start)
	    (insert sto-entry-marker)
	    t)
	t)
      (sto-entry-delete)
      (or (run-hooks 'sto-entry-next-hook) t))
     (ding))))

(defun sto-entry-next-nondeleting (&optional reverse)
  "Jump to next entry location to be filled in a form, and delete entry marker.
With prefix argument REVERSE, jump to first such location in reverse direction.
When used repeatedly, prefix argument changes the direction of the jump.

Usage:  (sto-entry-next-nondeleting &optional REVERSE)" 
  (interactive "P")
  (sto-entry-next reverse t))

(defun sto-entry-delete ()
  "Delete a marker indicating an entry location for filling out a form.   
Current position is assumed to be at the end of the marker to be deleted.
Exception:  A marker enclosed between static marker delimiters is not deleted."
;  (interactive)
  (if (not (sto-entry-at-static-marker))
      (or (backward-delete-char-untabify (length sto-entry-marker)) t)
    t))

;; Insert a marker
(defun sto-entry-insert ()
  "Insert a marker indicating an entry location for filling out a form"
  (interactive)
  (let* ((begin (- (point) (length sto-entry-static-marker-open-delim)))
	 (static (and (> begin 0)
		      (string= sto-entry-static-marker-open-delim
			       (buffer-substring begin (point))))))
    (insert sto-entry-marker)
    (if static
	(save-excursion
	  (insert sto-entry-static-marker-close-delim)))))

;; incremental search for the marker, with no deletion
(defun sto-entry-isearch ()
  "Insert the value of variable sto-entry-marker in the current isearch"
  (interactive)
  (isearch-process-search-string sto-entry-marker sto-entry-marker))

(define-key isearch-mode-map "\C-\\" 'sto-entry-isearch)


