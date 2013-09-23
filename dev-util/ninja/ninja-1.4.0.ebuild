# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ninja/ninja-1.4.0.ebuild,v 1.1 2013/09/23 03:15:30 phajdan.jr Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit bash-completion-r1 elisp-common python-any-r1 toolchain-funcs

if [ "${PV}" = "999999" ]; then
	EGIT_REPO_URI="git://github.com/martine/ninja.git http://github.com/martine/ninja.git"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="https://github.com/martine/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
fi

DESCRIPTION="A small build system similar to make."
HOMEPAGE="http://github.com/martine/ninja"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="doc emacs test vim-syntax zsh-completion"

DEPEND="
	${PYTHON_DEPS}
	dev-util/re2c
	doc? (
		app-text/asciidoc
		app-doc/doxygen
		dev-libs/libxslt
	)
	test? ( dev-cpp/gtest )
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

src_compile() {
	# If somebody wants to cross-compile, we will probably need to do 2 builds.
	tc-export AR CXX

	"${PYTHON}" bootstrap.py --verbose || die

	if use doc; then
		./ninja -v doxygen manual || die
	fi

	if use emacs; then
		elisp-compile misc/ninja-mode.el || die
	fi
}

src_test() {
	./ninja -v ninja_test || die
	./ninja_test || die
}

src_install() {
	dodoc README HACKING.md
	if use doc; then
		dohtml -r doc/doxygen/html/*
		dohtml doc/manual.html
	fi
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
