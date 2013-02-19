# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-data/iscan-data-1.22.0.1.ebuild,v 1.1 2013/02/19 10:38:54 flameeyes Exp $

EAPI=4

inherit eutils versionator

MY_PV="$(get_version_component_range 1-3)"
MY_PVR="$(replace_version_separator 3 -)"

DESCRIPTION="Image Scan! for Linux data files"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="http://dev.gentoo.org/~flameeyes/avasys/${PN}_${MY_PVR}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libxslt"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# create udev rules
	dodir /lib/udev/rules.d
	"${D}usr/$(get_libdir)/iscan-data/make-policy-file" \
		--force --quiet --mode udev \
		-d "${D}usr/share/iscan-data/epkowa.desc" \
		-o "${D}$(get_libdir)/udev/rules.d/99-iscan.rules"

	# install docs
	dodoc NEWS SUPPORTED-DEVICES KNOWN-PROBLEMS
}
