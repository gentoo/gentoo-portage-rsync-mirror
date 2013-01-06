# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pcc/pcc-1.0.1_pre20121112.ebuild,v 1.2 2012/11/13 23:05:42 mr_bones_ Exp $

EAPI=2

inherit eutils versionator autotools

DESCRIPTION="pcc portable c compiler"
HOMEPAGE="http://pcc.ludd.ltu.se"

SRC_URI="ftp://pcc.ludd.ltu.se/pub/${PN}/${PN}-${PVR/*_pre/}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~amd64-fbsd"
IUSE=""
DEPEND=">=dev-libs/pcc-libs-${PV}"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${PN}-${PVR/*_pre/}/

src_prepare() {
	sed -i -e 's/AC_CHECK_PROG(strip,strip,yes,no)//' configure.ac || die "Failed to fix configure.ac"
	sed -i -e 's/AC_SUBST(strip)//' configure.ac || die "Failed to fix configure.ac more"
	eautoreconf
}

src_compile() {
	# not parallel-safe yet
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
