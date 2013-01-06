# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/mirrorselect/mirrorselect-2.2.0-r1.ebuild,v 1.1 2012/12/16 06:12:56 dolsen Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.1"
PYTHON_USE_WITH="xml"
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

inherit eutils distutils python prefix

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI="http://dev.gentoo.org/~dolsen/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux"

# Note: dev-lang/python dependencies are so emerge will print a blocker if any
# installed slot of python is not built with +xml.  This is used since
# PYTHON_USE_WITH just dies in the middle of the emerge. See bug 399331.
RDEPEND="
	>=dev-lang/python-2.6[xml]
	!>=dev-lang/python-2.6[-xml]
	dev-util/dialog
	net-analyzer/netselect
	"
#	virtual/python-argparse"

src_prepare() {
	epatch "${FILESDIR}/2.2.0-Ignore-inaccessible-fsmirrors.patch"
	epatch "${FILESDIR}/2.2.0-Fix-setup.py-PVR.patch"
	eprefixify setup.py mirrorselect/main.py
}

distutils_src_compile_pre_hook() {
	echo Now setting version... VERSION="${PVR}" "$(PYTHON)" setup.py set_version
	VERSION="${PVR}" "$(PYTHON)" setup.py set_version || die "setup.py set_version failed"
}

src_compile() {
	distutils_src_compile
}

src_install() {
	python_convert_shebangs -r "" build-*/scripts-*
	distutils_src_install
}

pkg_postinst() {
	distutils_pkg_postinst
}
