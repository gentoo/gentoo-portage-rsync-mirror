# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsmi/libsmi-0.4.8-r1.ebuild,v 1.9 2012/09/03 19:51:16 blueness Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="A Library to Access SMI MIB Information"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/libsmi"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-CVE-2010-2891.patch
}

src_configure() {
	replace-flags -O? -O2
	econf
}

src_test() {
	# sming test is known to fail and some other fail if LC_ALL!=C:
	# http://mail.ibr.cs.tu-bs.de/pipermail/libsmi/2008-March/001014.html
	sed -i '/^[[:space:]]*smidump-sming.test \\$/d' test/Makefile
	LC_ALL=C emake -j1 check || die "Make check failed. See above for details."
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc smi.conf-example ANNOUNCE ChangeLog README THANKS TODO \
		doc/{*.txt,smi.dia,smi.dtd,smi.xsd}
}
