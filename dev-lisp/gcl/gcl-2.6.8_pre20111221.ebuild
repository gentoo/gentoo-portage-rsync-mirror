# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.6.8_pre20111221.ebuild,v 1.2 2012/06/07 18:59:25 zmedico Exp $

EAPI=3

#removing flag-o-matic results in make install failing due to a segfault
inherit elisp-common eutils flag-o-matic

DESCRIPTION="GNU Common Lisp"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
SRC_URI="http://dev.gentoo.org/~grozin/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+ansi debug doc emacs +readline tk X"

# See bug #205803
RESTRICT="strip"

RDEPEND="emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )
	>=dev-libs/gmp-4.1
	tk? ( dev-lang/tk )
	X? ( x11-libs/libXt x11-libs/libXext x11-libs/libXmu x11-libs/libXaw )
	virtual/latex-base"
DEPEND="${RDEPEND}
	doc? ( virtual/texi2dvi )
	>=app-text/texi2html-1.64
	>=sys-devel/autoconf-2.52"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-default-el.patch
}

src_configure() {
	local myconfig=""
	if use tk; then
		myconfig="${myconfig} --enable-tkconfig=/usr/lib --enable-tclconfig=/usr/lib"
	fi
	myconfig="${myconfig} \
		--enable-emacsdir=/usr/share/emacs/site-lisp/gcl \
		--enable-dynsysgmp \
		--disable-xdr
		$(use_enable readline) \
		$(use_with X x) \
		$(use_enable debug) \
		$(use_enable ansi)"

	einfo "Configuring with the following:
${myconfig}"
	econf ${myconfig}
}

src_compile() {
	make || die "make failed"
	sed -e 's,@EXT@,,g' debian/in.gcl.1 >gcl.1
}

src_test() {
	local make_ansi_tests_clean="rm -f test.out *.fasl *.o \
	*.so *~ *.fn *.x86f *.fasl *.ufsl"
	if use ansi; then
		cd ansi-tests

		( make clean && make test-unixport ) \
		|| die "make ansi-tests failed!"

		cat "${FILESDIR}/bootstrap-gcl" \
		| ../unixport/saved_ansi_gcl

		cat "${FILESDIR}/bootstrap-gcl" \
		|sed s/bootstrapped_ansi_gcl/bootstrapped_r_ansi_gcl/g \
		| ./bootstrapped_ansi_gcl

		( ${make_ansi_tests_clean} && \
		echo "(load \"gclload.lsp\")" \
		| ./bootstrapped_r_ansi_gcl ) \
		|| die "Phase 2, bootstraped compiler failed in tests"

	else

		ewarn "Upstream provides tests only for ansi-gcl."
		ewarn "Please emerge with ansi USE flag enabled"
		ewarn "if you wnat to run the ansi tests."

		cat "${FILESDIR}/bootstrap-gcl" \
		| sed s/bootstrapped_ansi_gcl/bootstrapped_gcl/g \
		| unixport/saved_gcl

		cat "${FILESDIR}/bootstrap-gcl" \
		| sed s/bootstrapped_ansi_gcl/bootstrapped_r_gcl/g \
		| ./bootstrapped_gcl

		for x in "./bootstrapped_r_gcl" "unixport/saved_gcl" ; do
			echo "(compiler::emit-fn t)" \
				| ${x} \
				|| die "Phase 2, bootstraped compiler failed in tests"
		done
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}"usr/share/doc/${PN}-si "${D}"usr/share/doc/${PN}-tk

	dosed /usr/bin/gcl
	fperms 0755 /usr/bin/gcl

	dodoc readme* RELEASE* ChangeLog* doc/*
	doman gcl.1
	doinfo info/*.info*

	if use emacs; then
		mv "${D}"usr/share/emacs/site-lisp/${PN}/add-default.el "${T}"/50${PN}-gentoo.el
		elisp-site-file-install "${T}"/50${PN}-gentoo.el
		elisp-install ${PN} elisp/*
		fperms 0644 /usr/share/emacs/site-lisp/gcl/*
	else
		rm -rf "${D}"usr/share/emacs
	fi

	if use doc; then
		mv "${D}"usr/share/doc/*.dvi "${D}"usr/share/doc/dwdoc* "${D}"usr/share/doc/${PF}/
	else
		rm -rf "${D}"usr/share/doc/*.dvi "${D}"usr/share/doc/dwdoc*
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
