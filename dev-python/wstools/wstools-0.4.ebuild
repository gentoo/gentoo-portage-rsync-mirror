# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wstools/wstools-0.4.ebuild,v 1.3 2012/08/02 22:15:36 neurogeek Exp $

EAPI="4"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml(+)"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="WSDL parsing services package for Web Services for Python"
HOMEPAGE="https://github.com/kiorky/wstools http://pypi.python.org/pypi/wstools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	find -name .cvsignore -print0 | xargs -0 rm -f
}
