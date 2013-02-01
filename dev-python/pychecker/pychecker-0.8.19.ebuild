# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.19.ebuild,v 1.10 2013/02/01 04:29:35 idella4 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Python source code checking tool"
HOMEPAGE="http://pychecker.sourceforge.net/ http://pypi.python.org/pypi/PyChecker"
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="pycheckrc"
PYTHON_VERSIONED_EXECUTABLES=("/usr/bin/pychecker")

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}"/${P}-version.patch

	# Disable installation of unneeded files.
	sed -e "/'data_files'       :/d" -i setup.py || die "sed failed"

	# Strip final "/" from root.
	sed -e 's:root = self\.distribution\.get_command_obj("install")\.root:&\.rstrip("/"):' -i setup.py || die "sed failed"

	epatch "${FILESDIR}/${P}-create_script.patch"
}
