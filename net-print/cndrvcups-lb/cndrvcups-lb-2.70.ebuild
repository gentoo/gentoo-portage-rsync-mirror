# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cndrvcups-lb/cndrvcups-lb-2.70.ebuild,v 1.1 2013/06/29 11:28:43 pacho Exp $

EAPI=5
inherit eutils autotools versionator

MY_PV="$(delete_all_version_separators)"
SOURCES_NAME="Linux_UFRII_PrinterDriver_V${MY_PV}_uk_EN"

DESCRIPTION="Canon UFR II / LIPSLX Printer Driver for Linux"
HOMEPAGE="http://support-au.canon.com.au/contents/AU/EN/0100270808.html"
SRC_URI="http://pdisp01.c-wss.com/gdl/WWUFORedirectTarget.do?id=MDEwMDAwMjcwODA5&cmp=ABS&lang=EN -> ${SOURCES_NAME}.tar.gz"

LICENSE="Canon-UFR-II"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# Needed because GPL2 stuff miss their sources in tarball
RESTRICT="mirror"

RDEPEND="
	dev-libs/libxml2
	gnome-base/libglade
	net-print/cups
	~net-print/cndrvcups-common-lb-${PV}
	x11-libs/gtk+:2
"
DEPEND="${DEPEND}"

S="${WORKDIR}/${SOURCES_NAME}/Sources/${P}"
MAKEOPTS+=" -j1"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${SOURCES_NAME}/Sources/"
	unpack ./${P}-1.tar.gz
}

change_dir() {
	for i in ppd pstoufr2cpca cngplp cngplp/files cpca ; do
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

src_install() {
	default
	prune_libtool_files
}
