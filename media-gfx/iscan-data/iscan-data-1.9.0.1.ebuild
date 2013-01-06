# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-data/iscan-data-1.9.0.1.ebuild,v 1.3 2011/10/15 23:13:49 ssuominen Exp $

EAPI=4

inherit eutils versionator

MY_PV="$(get_version_component_range 1-3)"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="Image Scan! for Linux data files"
HOMEPAGE="http://avasys.jp/english/linux_e/"
SRC_URI="http://linux.avasys.jp/drivers/iscan-data/${MY_PV}/${PN}_$(replace_version_separator 3 -).tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/libxslt"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# create udev rules
	dodir /lib/udev/rules.d
	"${D}usr/lib64/iscan-data/make-policy-file" \
		--force --quiet --mode udev \
		-d "${D}usr/share/iscan-data/epkowa.desc" \
		-o "${D}lib/udev/rules.d/99-iscan.rules"

	# install docs
	dodoc NEWS SUPPORTED-DEVICES KNOWN-PROBLEMS
}
