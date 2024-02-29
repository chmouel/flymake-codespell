
> [!CAUTION]
> This project has been deprecated, use the [ELPA](https://elpa.gnu.org/packages/flymake-codespell.html) version as an alternative.


# flymake-codespell - codespell backend for flymake

A simple flymake backend for [codespell](https://github.com/codespell-project/codespell)

## Installation

Using package.el (with emacs29's package-vc.el):

```elisp
(unless (package-installed-p 'flymake-codespell)
    (package-vc-install "https://github.com/chmouel/flymake-codespell"))
(use-package flymake-codespell
  :hook
  (prog-mode .
             (lambda ()
               (require 'flymake-codespell)
               (add-hook 'flymake-diagnostic-functions 'flymake-check-codespell nil t))))
```

## Copyright

### License

[GPL-3.0](./LICENSE)

## Authors

### Chmouel Boudjnah

- Fediverse - <[@chmouel@chmouel.com](https://fosstodon.org/@chmouel)>
- Twitter - <[@chmouel](https://twitter.com/chmouel)>
- Blog - <[https://blog.chmouel.com](https://blog.chmouel.com)>
