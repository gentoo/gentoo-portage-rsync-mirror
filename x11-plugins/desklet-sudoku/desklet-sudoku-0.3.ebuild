# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/desklet-sudoku/desklet-sudoku-0.3.ebuild,v 1.8 2010/07/22 14:27:22 ssuominen Exp $

DN=Sudoku
DESKLET_NAME=${DN}

inherit gdesklets

DESCRIPTION="A small Sudoku board with support for downloading boards from websudoku.com"
HOMEPAGE="http://archive.gdesklets.info/"
SRC_URI="http://archive.gdesklets.info/${MY_P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}

src_install() {
	DESKLET_NAME="${DN}"
	unset CONTROL_NAME
	cd "${WORKDIR}/Displays/${DESKLET_NAME}"
	gdesklets_src_install

	CONTROL_NAME="${DN}"
	unset DESKLET_NAME
	cd "${WORKDIR}/controls/${CONTROL_NAME}"
	gdesklets_src_install
}

pkg_postinst() {
	DESKLET_NAME="${DN}"
	unset CONTROL_NAME
	gdesklets_pkg_postinst

	CONTROL_NAME="${DN}"
	unset DESKLET_NAME
	cd "${WORKDIR}/controls/${CONTROL_NAME}"
	gdesklets_pkg_postinst
}
