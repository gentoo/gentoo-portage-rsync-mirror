# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gforth/gforth-0.7.0.ebuild,v 1.10 2012/04/24 09:55:47 mgorny Exp $

inherit elisp-common eutils toolchain-funcs flag-o-matic

DESCRIPTION="GNU Forth is a fast and portable implementation of the ANSI Forth language"
HOMEPAGE="http://www.gnu.org/software/gforth"
SRC_URI="mirror://gnu/gforth/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-freebsd ~x86-linux ~ppc-macos ~sparc-solaris"
IUSE="emacs"

DEPEND="dev-libs/ffcall
	emacs? ( virtual/emacs )"

RDEPEND="${DEPEND}"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-make-elc.patch"
}

src_compile() {
	local myconf

	# May want to add a USE flag for --enable-force-cdiv, if necessary
	# At this point I do not know when that is appropriate, and I don't
	# want to add an ebuild-specific USE flag without understanding.

	if ! use emacs; then
		myconf="--without-lispdir"
	fi

	econf ${myconf} || die "econf failed"

	# Parallel make breaks here
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS BUGS ChangeLog NEWS* README* ToDo doc/glossaries.doc doc/*.ps

	if use emacs; then
		elisp-install ${PN} gforth.el gforth.elc || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
