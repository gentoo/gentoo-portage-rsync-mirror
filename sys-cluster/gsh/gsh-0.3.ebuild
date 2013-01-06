# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gsh/gsh-0.3.ebuild,v 1.5 2012/02/10 02:57:18 patrick Exp $

EAPI=2
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="aggregate several remote shells into one"
HOMEPAGE="http://guichaz.free.fr/gsh/"
SRC_URI="http://guichaz.free.fr/gsh/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	sed -i -e "/setuptools-0.6/d" setup.py || die
}
