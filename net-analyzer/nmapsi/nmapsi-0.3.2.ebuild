# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmapsi/nmapsi-0.3.2.ebuild,v 1.1 2012/08/31 17:59:02 kensington Exp $

EAPI=4
PLOCALES="cs de es fr it pl pt_BR ru"
inherit eutils cmake-utils l10n

MY_PN="${PN}4"
MY_P="${MY_PN}-${PV/_/-}"

DESCRIPTION="A Qt4 frontend to nmap"
HOMEPAGE="http://www.nmapsi4.org/"
SRC_URI="http://nmapsi4.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}
	net-analyzer/nmap"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS NEWS README TODO Translation )

src_prepare() {
	l10n_for_each_disabled_locale_do nmapsi_disable_locale
}

nmapsi_disable_locale() {
	sed -e "s:ts/${MY_PN}_${1}.ts::" \
		-i ${MY_PN}/CMakeLists.txt || die
	sed -e "s:ts/${MY_PN}-logr_${1}.ts::" \
		-i ${MY_PN}-logr/CMakeLists.txt || die
}
