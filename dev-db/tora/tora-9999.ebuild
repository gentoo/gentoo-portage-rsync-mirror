# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tora/tora-9999.ebuild,v 1.1 2013/02/06 21:15:21 haubi Exp $

EAPI=2

inherit cmake-utils eutils

if [[ ${PV} == 9999 ]]; then
	ESVN_REPO_URI="https://tora.svn.sourceforge.net/svnroot/tora/trunk/tora"
	inherit subversion
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
fi

DESCRIPTION="TOra - Toolkit For Oracle"
HOMEPAGE="http://tora.sourceforge.net"
IUSE="debug mysql oracle oci8-instant-client postgres"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""

DEPEND="
	dev-libs/ferrisloki
	x11-libs/qscintilla
	x11-libs/qt-gui:4
	x11-libs/qt-sql:4[mysql?,postgres?]
	x11-libs/qt-xmlpatterns:4
	oci8-instant-client? (
		dev-db/oracle-instantclient-basic
		dev-db/oracle-instantclient-sqlplus
	)
	postgres? ( dev-db/postgresql-server )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ( use oracle || use oci8-instant-client ) && [ -z "$ORACLE_HOME" ] ; then
		eerror "ORACLE_HOME variable is not set."
		eerror
		eerror "You must install Oracle >= 8i client for Linux in"
		eerror "order to compile TOra with Oracle support."
		eerror
		eerror "Otherwise specify -oracle in your USE variable."
		eerror
		eerror "You can download the Oracle software from"
		eerror "http://www.oracle.com/technetwork/indexes/downloads/"
		die
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-ext-loki.patch #383109
	sed -i \
		-e "/COPYING/ d" \
		CMakeLists.txt || die "Removal of COPYING file failed"
	# 'svn info' needs .svn subdirectory
	[[ ${PV} != 9999 ]] || ln -s "${ESVN_WC_PATH}"/.svn .svn || die
}

src_configure() {
	local mycmakeargs=()
	if use oracle || use oci8-instant-client ; then
		mycmakeargs=(-DENABLE_ORACLE=ON)
	else
		mycmakeargs=(-DENABLE_ORACLE=OFF)
	fi
	mycmakeargs+=(
		-DWANT_RPM=OFF
		-DWANT_BUNDLE=OFF
		-DWANT_BUNDLE_STANDALONE=OFF
		-DWANT_INTERNAL_QSCINTILLA=OFF
		-DWANT_INTERNAL_LOKI=OFF
		$(cmake-utils_use_enable postgres PGSQL)
		$(cmake-utils_use_want debug)
		# path variables
		-DTORA_DOC_DIR=share/doc/${PF}
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	doicon src/icons/${PN}.xpm || die
	domenu debian/${PN}.desktop || die
}
