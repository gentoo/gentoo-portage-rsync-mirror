# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mirall/mirall-1.2.1.ebuild,v 1.1 2013/02/28 23:12:22 creffett Exp $

EAPI=5

inherit cmake-utils

MY_P="${PN}-${PV/_/}"

DESCRIPTION="Synchronization of your folders with another computers"
HOMEPAGE="http://owncloud.org/"
SRC_URI="http://download.owncloud.com/download/${MY_P}.tar.bz2"

LICENSE="CC-BY-3.0 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	>=net-misc/csync-0.70.4
	sys-fs/inotify-tools
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-test:4
"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx virtual/latex-base )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Yay for fcked detection.
	export CSYNC_DIR="${EPREFIX}/usr/include/ocsync/"

	epatch "${FILESDIR}/${PN}-1.2.0_beta2-automagicness.patch"
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with doc SPHINX)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	if ! has_version net-misc/csync[samba]; then
		elog "For samba support, build net-misc/csync with USE=samba"
	fi
	if ! has_version net-misc/csync[sftp]; then
		elog "For sftp support, build net-misc/csync with USE=sftp"
	fi
}
