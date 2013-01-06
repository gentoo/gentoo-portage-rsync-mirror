# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/mirrorselect/mirrorselect-9999.ebuild,v 1.3 2012/12/16 06:12:56 dolsen Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.1"
PYTHON_USE_WITH="xml"
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

EGIT_MASTER="master"
#EGIT_BRANCH="master"

inherit distutils python git-2 prefix

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/mirrorselect.git"

DESCRIPTION="Tool to help select distfiles mirrors for Gentoo"
HOMEPAGE="http://www.gentoo.org/proj/en/portage/tools/index.xml"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS=""

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
	eprefixify setup.py mirrorselect/main.py
}

distutils_src_compile_pre_hook() {
	echo Now setting version... VERSION="9999-${EGIT_VERSION}" "$(PYTHON)" setup.py set_version
	VERSION="9999-${EGIT_VERSION}" "$(PYTHON)" setup.py set_version
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

	einfo "This is a development version."
	einfo "Please report any bugs you encounter."
	einfo "http://bugs.gentoo.org/"
}
