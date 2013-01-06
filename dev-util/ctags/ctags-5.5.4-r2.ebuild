# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ctags/ctags-5.5.4-r2.ebuild,v 1.17 2012/03/17 23:18:39 mattst88 Exp $

inherit eutils

DESCRIPTION="Exuberant Ctags creates tags files for code browsing in editors"
HOMEPAGE="http://ctags.sourceforge.net"
SRC_URI="mirror://sourceforge/ctags/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ebuilds.patch
	epatch "${FILESDIR}"/${P}-ruby-classes.patch
}

src_compile() {
	econf \
		--with-posix-regex \
		--without-readlib \
		--disable-etags \
		--enable-tmpdir=/tmp \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	# namepace collision with X/Emacs-provided /usr/bin/ctags -- we
	# rename ctags to exuberant-ctags (Mandrake does this also).
	mv "${D}"/usr/bin/{ctags,exuberant-ctags}
	mv "${D}"/usr/share/man/man1/{ctags,exuberant-ctags}.1

	dodoc FAQ NEWS README
	dohtml EXTENDING.html ctags.html
}
