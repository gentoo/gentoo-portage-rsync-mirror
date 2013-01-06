# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/hesiod/hesiod-3.1.0.ebuild,v 1.9 2012/08/08 20:24:42 ranger Exp $

EAPI="2"
inherit flag-o-matic eutils autotools

DESCRIPTION="system which uses existing DNS functionality to provide access to databases of information that changes infrequently"
HOMEPAGE="ftp://athena-dist.mit.edu/pub/ATHENA/hesiod"
SRC_URI="ftp://athena-dist.mit.edu/pub/ATHENA/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-patches.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE=""

src_prepare() {
	# Bug #26332
	filter-flags -fstack-protector

	# Patches stolen from Fedora hesiod-3.1.0-19.fc14.src.rpm
	rm -f aclocal.m4 || die "rm failed"
	EPATCH_SOURCE="${WORKDIR}/files/${PV}" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc NEWS README || die
}

pkg_postinst() {
	elog "hesinfo tools are no longer part of hesiod. Use net-dns/hesinfo
	instead"
}
