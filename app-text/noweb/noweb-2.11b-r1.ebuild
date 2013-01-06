# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/noweb/noweb-2.11b-r1.ebuild,v 1.7 2012/01/08 22:43:06 ulm Exp $

inherit eutils toolchain-funcs elisp-common

DESCRIPTION="a literate programming tool, lighter than web"
HOMEPAGE="http://www.eecs.harvard.edu/~nr/noweb/"
SRC_URI="http://www.eecs.harvard.edu/~nr/noweb/dist/${P}.tgz"

LICENSE="noweb emacs? ( GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="emacs examples"

DEPEND="virtual/tex-base
	dev-lang/icon
	sys-apps/debianutils
	emacs? ( virtual/emacs )"
RDEPEND=${DEPEND}

S=${WORKDIR}/${P}/src

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"

	# glibc2.10 compat (bug 270757)
#	mkdir d && cp -r c/* d/
	sed "s:getline (:getline_nonlibc (:" -i c/getline.{c,h} || die
	sed "s:getline(:getline_nonlibc(:" -i c/{notangle.c,getline.c,finduses.c} || die
#	diff -u d/ c/

	epatch "${FILESDIR}"/${PN}-2.9-security.patch
	# dont run texhash...
	sed -i -e "s/texhash/true/" Makefile
	# dont strip...
	sed -i -e "s/strip/true/" Makefile
}

src_compile() {
	# noweb tries to use notangle and noweb; see bug #50429
	( cd c; emake ICONC="icont" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LIBSRC="icon" ) || die
	export PATH="${PATH}:${T}"
	emake ICONC="icont" CC="$(tc-getCC)" BIN="${T}" LIB="${T}" LIBSRC="icon" install-code \
		|| die "make temporal install failed."

	emake ICONC="icont" CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LIBSRC="icon" || die "make failed"
	# Set awk to awk not nawk
	./awkname awk

	if use emacs; then
		elisp-compile elisp/noweb-mode.el || die "elisp-compile failed"
	fi
}

src_install () {
	# It needs the directories to exist first...
	dodir /usr/bin
	dodir /usr/libexec/${PN}
	dodir /usr/share/man
	dodir /usr/share/texmf/tex/inputs
	emake ICONC="icont" \
		BIN="${D}/usr/bin" \
		LIBSRC="icon" \
		LIBNAME="/usr/libexec/${PN}" \
		LIB="${D}/usr/libexec/${PN}" \
		MAN="${D}/usr/share/man" \
		TEXNAME="/usr/share/texmf/tex/inputs" \
		TEXINPUTS="${D}/usr/share/texmf/tex/inputs" \
		install || die "make install failed"
	cd "${WORKDIR}/${P}"
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
	dodoc CHANGES README

	if use emacs; then
		elisp-install ${PN} src/elisp/noweb-mode.{el,elc} \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
	einfo "Running texhash to complete installation.."
	texhash
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
