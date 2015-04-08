# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/mirrorselect/mirrorselect-2.2.0.1.ebuild,v 1.15 2015/04/08 07:30:31 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE="xml"

inherit eutils distutils-r1 prefix

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="http://dev.gentoo.org/~dolsen/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux"

RDEPEND="
	dev-util/dialog
	net-analyzer/netselect
	"

python_prepare_all()  {
	python_export_best
	eprefixify setup.py mirrorselect/main.py
	echo Now setting version... VERSION="${PVR}" "${PYTHON}" setup.py set_version
	VERSION="${PVR}" "${PYTHON}" setup.py set_version || die "setup.py set_version failed"
	distutils-r1_python_prepare_all
}
