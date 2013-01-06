# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dfc/dfc-3.0.0.ebuild,v 1.1 2012/06/01 07:19:05 iksaif Exp $

EAPI=4
inherit cmake-utils

DESCRIPTION="A simple CLI tool that display file system usage, with colors"
HOMEPAGE="http://projects.gw-computing.net/projects/dfc"
SRC_URI="http://projects.gw-computing.net/attachments/download/63/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="nls? ( virtual/libintl )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		# avoid installing xdg config in /usr
		-DXDG_CONFIG_DIR="${EPREFIX}"/etc/xdg
		# use the standard Gentoo doc path
		-DDFC_DOC_PATH="${EPREFIX}"/usr/share/doc/${PF}
		# disable automagic dependency
		$(cmake-utils_use nls NLS_ENABLED)
	)

	cmake-utils_src_configure
}
