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
  (define-key processing-keymap "\C-c\C-e" 'export)
  (use-local-map processing-keymap)
  )

(defun processing-java-command ()
  (concat "processing-java"
	  " --sketch=" default-directory
	  " --force"))

(defun run ()
  "Preprocess, compile, and run a sketch."
  (interactive)
  (shell-command
   (concat (processing-java-command)
  	   " --output=" default-directory "output"
  	   " --run"
  	   " &")))

(defun export ()
  "Export an application"
  (interactive)
  (let ((platform
	 (cond ((eq system-type 'gnu/linux)
		"linux")
	       ((eq system-type 'darwin)
		("macosx"))
	       ((eq system-type 'windows-nt)
		("windows")))))
    (shell-command
     (concat (processing-java-command)
	     " --output=" default-directory "export/" platform
	     " --export --platform=" platform " --bits=" "64"
	     " &"))))

(provide 'processing-mode)
