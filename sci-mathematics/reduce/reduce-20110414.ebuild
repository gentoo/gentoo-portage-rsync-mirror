# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/reduce/reduce-20110414.ebuild,v 1.1 2011/09/22 11:15:33 grozin Exp $
EAPI=4
inherit elisp-common

DESCRIPTION="A general-purpose computer algebra system"
HOMEPAGE="http://reduce-algebra.sourceforge.net/
	http://reduce-algebra.com/"
IUSE="doc emacs gnuplot X"
SRC_URI="mirror://sourceforge/${PN}-algebra/${PN}-src-${PV}.tar.bz2"
LICENSE="BSD-2 X? ( LGPL-2.1 )"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="X? ( x11-libs/libXrandr
		x11-libs/libXcursor
		x11-libs/libXft )
	gnuplot? ( sci-visualization/gnuplot )
	emacs? ( virtual/emacs )"
DEPEND="${RDEPEND}"

src_configure() {
	# If you pass --prefix to this damn configure,
	# make (not make install!) will try to install stuff
	# into the live file system => sandbox violation
	# Therefore, I cannot use econf here
	# Also, make calls configure in maintainer mode in subdirs *by design*
	# The trunk sucks less => WONTFIX until the next release
	./configure --with-csl $(use_with X gui)
	# psl build requires Internet connection at build time
	# we cannot support it
}

src_compile() {
	emake STRIP=true

	pushd cslbuild/*/csl/reduce.doc > /dev/null
	rm -f *.txt *.tex
	popd > /dev/null

	if use emacs; then
		einfo "Compiling emacs lisp files"
		elisp-compile generic/emacs/*.el || die "elisp-compile failed"
	fi
}

src_test() {
	emake testall || die "emake testall failed"
}

src_install() {
	pushd cslbuild/*/csl > /dev/null
	exeinto /usr/lib/${PN}
	doexe reduce csl
	insinto /usr/lib/${PN}
	doins reduce.img csl.img
	doins -r reduce.doc
	if use X; then
		doins -r reduce.fonts
	fi
	popd > /dev/null
	exeinto /usr/bin
	doexe "${FILESDIR}/redcsl" "${FILESDIR}/csl"
	dodoc README BUILDING DEPENDENCY_TRACKING
	dosym /usr/lib/${PN}/${PN}.doc /usr/share/doc/${PF}/html

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/util/r38.pdf
	fi

	if use emacs; then
		pushd generic/emacs > /dev/null
		elisp-install ${PN} *.el *.elc || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/64${PN}-gentoo.el"
		popd > /dev/null
	fi
}
