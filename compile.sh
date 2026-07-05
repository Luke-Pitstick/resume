#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

jobname="Luke_Pitstick_Resume"
build_dir="$(mktemp -d "${TMPDIR:-/tmp}/resume-build.XXXXXX")"
cleanup_sidecars() {
  rm -f "$jobname".aux "$jobname".log "$jobname".out
}
cleanup() {
  rm -rf "$build_dir"
  cleanup_sidecars
}
trap cleanup EXIT
cleanup_sidecars

# Help LaTeX find packages when the CLI does not pick up the TeX tree.
texroot="$(kpsewhich -var-value=TEXMFROOT)"
export TEXINPUTS=".:$texroot/texmf-dist/tex//:${TEXINPUTS:-}"

for _ in 1 2; do
  pdflatex -interaction=nonstopmode -halt-on-error \
    -output-directory="$build_dir" \
    "$jobname.tex"
done

cp "$build_dir/$jobname.pdf" "$jobname.pdf"
