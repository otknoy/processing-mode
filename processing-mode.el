;;; processing-mode for emacs
;;; processing-mode.el ver. 0.1
;;; by Naoya Otsuka

(setq auto-mode-alist
      (cons '("\\.pde$" . processing-mode) auto-mode-alist))

(defun processing-mode ()
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'processing-mode
	mode-name "Processing")
  (java-mode)
  (run-hooks 'processing-mode-hook)
  (setq processing-keymap (make-keymap))
  (define-key processing-keymap "\C-c\C-r" 'run)
  (use-local-map processing-keymap)
  )

  
(defun run ()
  "sketch run"
  (interactive)
  (shell-command
   (concat "processing-java"
	   " --sketch=" default-directory
	   " --output=" default-directory "output"
	   " --run --force &")))

(provide 'processing-mode)