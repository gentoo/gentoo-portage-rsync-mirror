# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cndrvcups-common-lb/cndrvcups-common-lb-2.70.ebuild,v 1.1 2013/06/29 11:29:50 pacho Exp $

EAPI=5
inherit autotools versionator

MY_PV="$(delete_all_version_separators)"
SOURCES_NAME="Linux_UFRII_PrinterDriver_V${MY_PV}_uk_EN"

DESCRIPTION="Common files for Canon drivers"
HOMEPAGE="http://support-au.canon.com.au/contents/AU/EN/0100270808.html"
SRC_URI="http://pdisp01.c-wss.com/gdl/WWUFORedirectTarget.do?id=MDEwMDAwMjcwODA5&cmp=ABS&lang=EN -> ${SOURCES_NAME}.tar.gz"

LICENSE="Canon-UFR-II GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# Needed because GPL2 stuff miss their sources in tarball
RESTRICT="mirror"

RDEPEND="
	dev-libs/libxml2
	gnome-base/libglade
	net-print/cups
	x11-libs/gtk+:2
"
DEPEND="${DEPEND}"

S="${WORKDIR}/${SOURCES_NAME}/Sources/${P/-lb/}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${SOURCES_NAME}/Sources/"
	unpack ./${P/-lb/}-1.tar.gz
}

change_dir() {
	for i in cngplp buftool backend; do
		cd "${i}"
		"${@}"
		cd "${S}"
	done
}

src_prepare() {
	export "LIBS=-lgmodule-2.0"
	change_dir eautoreconf
}

src_configure() {
	change_dir econf
}

src_compile() {
	change_dir emake
}

src_install() {
	MAKEOPTS+=" -j1" default
}
