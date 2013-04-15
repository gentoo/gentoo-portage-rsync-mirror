# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mirall/mirall-1.2.4.ebuild,v 1.1 2013/04/15 17:43:10 kensington Exp $

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
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qttest:4
"
DEPEND="${RDEPEND}
	doc? (
		dev-python/sphinx
		dev-texlive/texlive-latexextra
		virtual/latex-base
	)
"

S=${WORKDIR}/${MY_P}

src_configure() {
	export CSYNC_DIR="${EPREFIX}/usr/include/ocsync/"

	local mycmakeargs=(
		-DCMAKE_INSTALL_DOCDIR=/usr/share/doc/${PF}
		$(cmake-utils_use_with doc)
	)
	cmake-utils_src_configure
}

src_compile() {
	use doc && cmake-utils_src_compile -j1 doc
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	mkdir "${D}/etc/"
	mv "${D}/usr/etc/sync-exclude.lst" "${D}/etc/"
	rm -r "${D}/usr/etc/"
}

pkg_postinst() {
	if ! has_version net-misc/csync[samba]; then
		elog "For samba support, build net-misc/csync with USE=samba"
	fi
	if ! has_version net-misc/csync[sftp]; then
		elog "For sftp support, build net-misc/csync with USE=sftp"
	fi
}
