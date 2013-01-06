# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/elvis/elvis-2.2.0-r3.ebuild,v 1.13 2012/09/09 17:10:12 armin76 Exp $

inherit eutils versionator

MY_PV=$(replace_version_separator 2 '_')

DESCRIPTION="A vi/ex clone"
HOMEPAGE="ftp://ftp.cs.pdx.edu/pub/elvis/"
SRC_URI="ftp://ftp.cs.pdx.edu/pub/elvis/${PN}-${MY_PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="X"

DEPEND=">=sys-libs/ncurses-5.2
	X? ( >=x11-proto/xproto-7.0.4
		>=x11-libs/libX11-1.0.0
		>=x11-libs/libXt-1.0.0
		>=x11-libs/libXpm-3.5.4.2
		>=x11-libs/libXft-2.1.8.2 )
	app-admin/eselect-vi"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/ft2.3-symbol-collision-fix.patch \
		"${FILESDIR}"/${P}-glibc-2.10.patch
}

src_compile() {
	./configure \
		--prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share/elvis \
		--docdir=/usr/share/doc/"${PF}" \
		$(use_with X x) \
		|| die "configure failed"

	# Some Makefile fixups (must happen after configure)
	# Use our CFLAGS
	sed -i -e "s:gcc -O2:$(tc-getCC) ${CFLAGS}:" Makefile || die "sed 1 failed"

	# We'll install the man-pages ourselves
	sed -i -e '/^	sh instman.sh/d' Makefile || die "sed 2 failed"

	# Don't try to write to /etc
	sed -i -e 's,/etc/elvis,${D}/etc/elvis,g' Makefile || die "sed 3 failed"

	# Use LDFLAGS
	sed -i -e "s#\$(CC) \$(CFLAGS)#\$(CC) \$(CFLAGS) ${LDFLAGS}#" Makefile || \
		die "sed 4 failed"

	emake || die "make failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/share/elvis
	dodir /usr/share/doc/"${PF}"
	dodir /etc
	make install \
		PREFIX="${D}"/usr \
		BINDIR="${D}"/usr/bin \
		DATADIR="${D}"/usr/share/elvis \
		DOCDIR="${D}"/usr/share/doc/"${PF}" || die 'make install failed'

	# Install the man-pages
	mv doc/elvis.man doc/elvis.1
	mv doc/elvtags.man doc/elvtags.1
	mv doc/ref.man doc/ref.1
	doman doc/*.1 || die 'doman failed'

	# Fixup some READMEs
	sed -i -e "s,${D},,g" "${D}"/etc/elvis/README \
		|| die 'sed /etc/elvis/README failed'
	sed -i -e "s,${D},,g" "${D}"/usr/share/elvis/README \
		|| die 'sed /usr/share/elvis/README failed'
}

pkg_postinst() {
	einfo "Setting /usr/bin/vi symlink"
	eselect vi set "${PN}"
}

pkg_postrm() {
	einfo "Updating /usr/bin/vi symlink"
	eselect vi update
}
