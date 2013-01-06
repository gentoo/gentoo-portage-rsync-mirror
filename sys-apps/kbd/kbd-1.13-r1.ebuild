# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.13-r1.ebuild,v 1.10 2010/10/08 01:57:43 leio Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://freshmeat.net/projects/kbd/"
SRC_URI="ftp://ftp.altlinux.org/pub/people/legion/kbd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="nls"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CFLAGS/s:-O2:${CFLAGS}:g" \
		-e "/^LDFLAGS/s:-s:${LDFLAGS}:" \
		-e "s:install -s:install:" \
		src/Makefile.in \
		openvt/Makefile

	if tc-is-cross-compiler; then
		tc-export CC
		# Cross-compiling: don't run test programs
		sed -i -e "s:&& ./conftest::" configure || \
			die "Could not do sed configure for cross-compile"
	fi

	epatch "${FILESDIR}"/${P}-dont-use-error.patch
	epatch "${FILESDIR}"/${PN}-1.12-configure-LANG.patch #128253

	# fix unimap path issue caused by Debian patch
	epatch "${FILESDIR}"/${PN}-1.12-unimap.patch

	# Provide a QWERTZ and QWERTY cz map #19010
	cp data/keymaps/i386/{qwerty,qwertz}/cz.map || die "cz qwerty"
	epatch "${FILESDIR}"/${PN}-1.12-cz-qwerty-map.patch

	# Fix jp map to recognize Ctrl-[ as Escape #71870
	epatch "${FILESDIR}"/${PN}-1.12-jp-escape.patch

	# cross-compile fails for powerpc targets bug #133856
	epatch "${FILESDIR}"/${PN}-1.12-xcompile.patch
}

src_compile() {
	local myconf=
	# Non-standard configure script; --disable-nls to
	# disable NLS, nothing to enable it.
	use nls || myconf="--disable-nls"
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share \
		${myconf} || die

	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	mv "${D}"/usr/bin/setfont "${D}"/bin/
	dosym /bin/setfont /usr/bin/setfont

	dodoc CHANGES CREDITS README
	dodir /usr/share/doc/${PF}/html
	cp -dR doc/* "${D}"/usr/share/doc/${PF}/html/
}
