# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychecker/pychecker-0.8.18.ebuild,v 1.10 2012/01/26 13:46:47 ssuominen Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Tool for finding common bugs in python source code"
SRC_URI="mirror://sourceforge/pychecker/${P}.tar.gz"
HOMEPAGE="http://pychecker.sourceforge.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="pychecker pychecker2"
DOCS="pycheckrc"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/pychecker-0.8.17-no-data-files.patch
	epatch "${FILESDIR}"/pychecker-0.8.18-pychecker2.patch
	sed -e 's:root = self\.distribution\.get_command_obj("install")\.root:&\.rstrip("/"):' -i setup.py || die "sed setup.py failed"
}
