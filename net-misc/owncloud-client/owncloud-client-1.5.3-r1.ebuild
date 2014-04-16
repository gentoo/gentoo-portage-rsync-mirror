# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/owncloud-client/owncloud-client-1.5.3-r1.ebuild,v 1.1 2014/04/16 11:33:49 voyageur Exp $

EAPI=5

inherit cmake-utils

MY_P="mirall-${PV/_/}"

DESCRIPTION="Synchronize files from ownCloud Server with your computer"
HOMEPAGE="http://owncloud.org/"
SRC_URI="http://download.owncloud.com/desktop/stable/${MY_P}.tar.bz2"

LICENSE="CC-BY-3.0 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc samba +sftp test"

RDEPEND=">=dev-db/sqlite-3.4:3
	dev-libs/qtkeychain
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	dev-qt/qtsql:4
	dev-qt/qttest:4
	dev-qt/qtwebkit:4
	net-libs/neon[ssl]
	sys-fs/inotify-tools
	virtual/libiconv
	samba? ( >=net-fs/samba-3.5 )
	sftp? ( >=net-libs/libssh-0.5 )
	!net-misc/ocsync"
DEPEND="${RDEPEND}
	doc? (
		dev-python/sphinx
		dev-texlive/texlive-latexextra
		virtual/latex-base
	)
	test? ( dev-util/cmocka )"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-man-page-location-fix.patch )

src_configure() {
	local mycmakeargs=(
		-DSYSCONF_INSTALL_DIR="${EPREFIX}"/etc
		-DCMAKE_INSTALL_DOCDIR=/usr/share/doc/${PF}
		-DWITH_ICONV=ON
		$(cmake-utils_use_with doc DOC)
		$(cmake-utils_use test UNIT_TESTING)
		$(cmake-utils_use_find_package samba Libsmbclient)
		$(cmake-utils_use_find_package sftp LibSSH)
	)

	cmake-utils_src_configure
}

src_test() {
	# 1 test needs an existing ${HOME}/.config directory
	mkdir "${T}"/.config
	export HOME="${T}"
	cmake-utils_src_test
}
