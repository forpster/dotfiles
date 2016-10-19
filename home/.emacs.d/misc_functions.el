; Allow tab to either ident or complete based on cursor position
(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (dabbrev-expand nil)
    (indent-for-tab-command)
    ))

; When saving files in specific modes strip tabs and unwanted whitespace
(defun rok-cleanup ()
  "Untabify and remove trailing whitespace"
  (interactive)
  (untabify (point-min) (point-max))
  (delete-trailing-whitespace))

; Duplicate a line and comment out original
(defun rok-duplicate-line (&optional commentfirst)
  "comment line at point; if COMMENTFIRST is non-nil, comment the original"
  (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when commentfirst
    (comment-region (region-beginning) (region-end)))
    (insert
      (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))
