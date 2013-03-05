# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ninja/ninja-1.1.0.ebuild,v 1.3 2013/03/05 18:39:10 ago Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit bash-completion-r1 elisp-common python toolchain-funcs

if [ "${PV}" = "999999" ]; then
	EGIT_REPO_URI="git://github.com/martine/ninja.git http://github.com/martine/ninja.git"
	inherit git-2
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="mirror://github/martine/${PN}/tarball/v${PV} -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86 ~ppc-macos"
fi

DESCRIPTION="A small build system similar to make."
HOMEPAGE="http://github.com/martine/ninja"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="doc emacs vim-syntax zsh-completion"

DEPEND="
	dev-util/re2c
	doc? ( app-text/asciidoc app-doc/doxygen )
	"
RDEPEND="
	emacs? ( virtual/emacs )
	vim-syntax? (
		|| (
			app-editors/vim
			app-editors/gvim
		)
	)
	zsh-completion? ( app-shells/zsh )
	!<net-irc/ninja-1.5.9_pre14-r1" #436804

pkg_setup() {
	python_set_active_version 2
}

src_compile() {
	tc-export BUILD_CXX
	./bootstrap.py || die
	if use doc; then
		./ninja doxygen || die
	fi

	if use emacs; then
		elisp-compile misc/ninja-mode.el || die
	fi
}

src_install() {
	dodoc README HACKING.md
	use doc && dohtml -r doc/doxygen/html/*
	dobin ninja

	newbashcomp misc/bash-completion "${PN}"

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax/
		doins misc/"${PN}".vim

		echo 'au BufNewFile,BufRead *.ninja set ft=ninja' > "${T}/${PN}.vim"
		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${T}/${PN}.vim"
	fi

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		newins misc/zsh-completion _ninja
	fi

	if use emacs; then
		cd misc || die
		elisp-install ${PN} ninja-mode.el* || die
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
