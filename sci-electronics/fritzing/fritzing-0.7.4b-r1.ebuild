# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/fritzing/fritzing-0.7.4b-r1.ebuild,v 1.1 2012/04/18 23:16:57 idl0r Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="Electronic Design Automation"
HOMEPAGE="http://fritzing.org/"
SRC_URI="http://fritzing.org/download/${PV}/source-tarball/${P}.source.tar.bz2"

LICENSE="CCPL-Attribution-ShareAlike-3.0 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-sql:4[sqlite]
	dev-libs/quazip"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.40"

S="${WORKDIR}/${P}.source"

src_prepare() {
	local translations=

	qt4-r2_src_prepare

	# Get a rid of the bundled libs
	# Bug 412555 and
	# https://code.google.com/p/fritzing/issues/detail?id=1898
	rm -rf src/libs/quazip pri/quazip.pri src/libs/boost*

	epatch "${FILESDIR}/no-bundled-quazip.patch"
	epatch "${FILESDIR}/no-bundled-boost.patch"

	edos2unix ${PN}.desktop

	# Somewhat evil but IMHO the best solution
	for lang in $LINGUAS; do
		lang=${lang/linguas_}
		[ -f "translations/${PN}_${lang}.qm" ] && translations+=" translations/${PN}_${lang}.qm"
	done
	if [ -n "${translations}" ]; then
		sed -i -e "s:\(translations.extra =\) .*:\1	cp -p ${translations} \$(INSTALL_ROOT)\$\$PKGDATADIR/translations\r:" phoenix.pro || die
	else
		sed -i -e "s:translations.extra = .*:\r:" phoenix.pro || die
	fi
}
