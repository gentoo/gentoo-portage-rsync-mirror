# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythondialog/pythondialog-2.7.ebuild,v 1.11 2011/01/01 19:56:22 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A Python module for making simple text/console-mode user interfaces."
HOMEPAGE="http://pythondialog.sourceforge.net/"
SRC_URI="mirror://sourceforge/pythondialog/${PF}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-util/dialog"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="dialog.py"

src_prepare() {
	distutils_src_prepare
	sed -e "/^prefix=/d" -i setup.cfg || die "sed failed"
}
