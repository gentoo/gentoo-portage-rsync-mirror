# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/openssl-blacklist/openssl-blacklist-0.5.3.ebuild,v 1.1 2011/11/30 22:12:50 vapier Exp $

EAPI="4"

inherit eutils versionator

MY_PV=$(get_version_component_range 1-2)
MY_P="${PN}-${MY_PV}"
DEB_P="${PN}_${MY_PV}"
DEB_PVER=$(get_version_component_range 3)
DEB_PATCH="${DEB_P}-${DEB_PVER}.diff"

DESCRIPTION="Detection of weak ssl keys produced by certain debian versions between 2006 and 2008"
HOMEPAGE="https://launchpad.net/ubuntu/+source/openssl-blacklist/"
SRC_URI="mirror://debian/pool/main/o/${PN}/${DEB_P}.orig.tar.gz
	mirror://debian/pool/main/o/${PN}/${DEB_PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	EPATCH_OPTS="-p1" epatch "${WORKDIR}"/${DEB_PATCH}
}

src_install() {
	dobin openssl-vulnkey
	doman openssl-vulnkey.1
	insinto /usr/share/openssl-blacklist

	# ripped from debian/rules "install" target
	local keysize
	for keysize in 512 1024 2048 4096 ; do
		(
		cat debian/blacklist.prefix
		cat blacklists/{be32,le32,le64}/blacklist-${keysize}.db \
			| cut -d ' ' -f 5 | cut -b21- | sort
		) > blacklist.RSA-${keysize}
		doins blacklist.RSA-${keysize}
	done

}
