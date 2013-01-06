# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dosfstools/dosfstools-3.0.11.ebuild,v 1.4 2012/05/24 02:46:57 vapier Exp $

EAPI="3"

inherit toolchain-funcs flag-o-matic eutils

DESCRIPTION="DOS filesystem tools - provides mkdosfs, mkfs.msdos, mkfs.vfat"
HOMEPAGE="http://www.daniel-baumann.ch/software/dosfstools/"
SRC_URI="http://www.daniel-baumann.ch/software/dosfstools/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-linux"
IUSE=""
RESTRICT="test" # there is no test target #239071

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.0.11-name-ext.patch
	sed -i \
		-e '/^PREFIX/s:/local::' \
		-e '/^OPTFLAGS/s:=.*:=:' \
		Makefile || die
	append-lfs-flags
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install || die
	dodir /sbin
	mv "${ED}"/usr/sbin/*fsck* "${ED}"/sbin/ || die
	mv "${ED}"/usr/share/doc/{${PN},${PF}} || die
	prepalldocs
}
