# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/mirrorselect/mirrorselect-2.2.2.ebuild,v 1.5 2014/07/20 12:15:05 klausman Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE="xml"

inherit eutils distutils-r1 prefix

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Mirrorselect"
SRC_URI="http://dev.gentoo.org/~dolsen/releases/mirrorselect/${P}.tar.gz
	http://dev.gentoo.org/~dolsen/releases/mirrorselect/mirrorselect-test
	"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~alpha ~amd64 arm hppa ~ia64 ~x86"

RDEPEND="
	dev-util/dialog
	net-analyzer/netselect
	>=dev-python/ssl-fetch-0.2[${PYTHON_USEDEP}]
	"

python_prepare_all()  {
	python_export_best
	eprefixify setup.py mirrorselect/main.py
	echo Now setting version... VERSION="${PVR}" "${PYTHON}" setup.py set_version
	VERSION="${PVR}" "${PYTHON}" setup.py set_version || die "setup.py set_version failed"
	distutils-r1_python_prepare_all
}
