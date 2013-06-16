# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/mirrorselect/mirrorselect-9999.ebuild,v 1.4 2013/06/16 16:50:41 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
PYTHON_REQ_USE="xml"

inherit eutils distutils-r1 git-2 prefix

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/mirrorselect.git"
EGIT_MASTER="master"

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS=""

RDEPEND="
	dev-util/dialog
	net-analyzer/netselect
	"

python_prepare_all()  {
	python_export_best
	eprefixify setup.py mirrorselect/main.py
	echo Now setting version... VERSION="9999-${EGIT_VERSION}" "${PYTHON}" setup.py set_version
	VERSION="9999-${EGIT_VERSION}" "${PYTHON}" setup.py set_version || die "setup.py set_version failed"
}

pkg_postinst() {
	distutils_pkg_postinst

	einfo "This is a development version."
	einfo "Please report any bugs you encounter."
	einfo "http://bugs.gentoo.org/"
}
