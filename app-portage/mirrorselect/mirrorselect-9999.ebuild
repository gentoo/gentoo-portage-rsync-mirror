# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/mirrorselect/mirrorselect-9999.ebuild,v 1.9 2014/05/06 02:55:53 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE="xml"

inherit eutils distutils-r1 git-2 prefix

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/mirrorselect.git"
EGIT_MASTER="master"

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Mirrorselect"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS=""

RDEPEND="
	dev-util/dialog
	net-analyzer/netselect
	=dev-python/ssl-fetch-9999[${PYTHON_USEDEP}]
	"

python_prepare_all()  {
	python_export_best
	eprefixify setup.py mirrorselect/main.py
	echo Now setting version... VERSION="9999-${EGIT_VERSION}" "${PYTHON}" setup.py set_version
	VERSION="9999-${EGIT_VERSION}" "${PYTHON}" setup.py set_version || die "setup.py set_version failed"
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	distutils-r1_pkg_postinst

	einfo "This is a development version."
	einfo "Please report any bugs you encounter to:"
	einfo "https://bugs.gentoo.org/"
}
