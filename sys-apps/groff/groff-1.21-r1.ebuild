# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/groff/groff-1.21-r1.ebuild,v 1.5 2012/11/13 19:52:24 vapier Exp $

EAPI="3"

inherit autotools eutils toolchain-funcs

DESCRIPTION="Text formatter used for man pages"
HOMEPAGE="http://www.gnu.org/software/groff/groff.html"
SRC_URI="mirror://gnu/groff/${P}.tar.gz
	linguas_ja? ( mirror://gentoo/${P}-japanese.patch.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="examples X linguas_ja"

RDEPEND=">=sys-apps/texinfo-4.7-r1
	X? (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXmu
		x11-libs/libXaw
		x11-libs/libSM
		x11-libs/libICE
	)"
DEPEND="${RDEPEND}
	linguas_ja? ( virtual/yacc )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.19.2-man-unicode-dashes.patch #16108 #17580 #121502
	epatch "${FILESDIR}"/${PN}-1.20.1-pdfmark-parallel.patch

	# Make sure we can cross-compile this puppy
	if tc-is-cross-compiler ; then
		sed -i \
			-e '/^GROFFBIN=/s:=.*:=${EPREFIX}/usr/bin/groff:' \
			-e '/^TROFFBIN=/s:=.*:=${EPREFIX}/usr/bin/troff:' \
			-e '/^GROFF_BIN_PATH=/s:=.*:=:' \
			-e '/^GROFF_BIN_DIR=/s:=.*:=:' \
			contrib/*/Makefile.sub \
			doc/Makefile.in \
			doc/Makefile.sub || die "cross-compile sed failed"
	fi

	local pfx=
	use prefix && pfx=" Prefix"
	cat <<-EOF >> tmac/mdoc.local
	.ds volume-operating-system Gentoo${pfx}
	.ds operating-system Gentoo${pfx}/${KERNEL}
	.ds default-operating-system Gentoo${pfx}/${KERNEL}
	EOF

	if use linguas_ja ; then
		epatch "${WORKDIR}"/${P}-japanese.patch #255292 #350534
		eautoconf
		eautoheader
	fi

	# from upstream, #353287, #353377
	epatch "${FILESDIR}"/groff-1.21-makefile.patch
	epatch "${FILESDIR}"/groff-1.21-gnulib.patch
	epatch "${FILESDIR}"/${PN}-1.21-gnulib-cross.patch #363647
	# make sure we don't get a crappy `g' nameprefix on UNIX systems with real
	# troff (GROFF_G macro runs some test to see, its own troff doesn't satisfy)
	sed -i -e 's/^[ \t]\+g=g$/g=/' configure || die
}

src_configure() {
	econf \
		--with-appresdir="${EPREFIX}"/usr/share/X11/app-defaults \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_with X x) \
		$(use linguas_ja && echo --enable-japanese)
}

src_install() {
	emake install DESTDIR="${D}" || die

	# The following links are required for man #123674
	dosym eqn /usr/bin/geqn
	dosym tbl /usr/bin/gtbl

	dodoc BUG-REPORT ChangeLog MORE.STUFF NEWS \
		PROBLEMS PROJECTS README REVISION TODO VERSION

	use examples || rm -rf "${ED}"/usr/share/doc/${PF}/examples
}
