# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/torrentzip/torrentzip-0.2-r1.ebuild,v 1.3 2009/10/12 16:51:50 halcy0n Exp $

inherit versionator eutils autotools

DESCRIPTION="archiving program that uses standard values when creating zips to create identical files over multiple systems with the ability to create a torrentzip format from a zip file"
HOMEPAGE="https://sourceforge.net/projects/trrntzip"

MY_PN=trrntzip
MY_PV="$(replace_version_separator 1 '')"
MY_P=${MY_PN}_v${MY_PV}
S="${WORKDIR}"/${MY_PN}

SRC_URI="mirror://sourceforge/trrntzip/${MY_P}_src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-libs/zlib"

S=${WORKDIR}/trrntzip

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/fix-perms.patch

	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README AUTHORS
}
