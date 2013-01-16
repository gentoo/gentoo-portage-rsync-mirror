# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chardet/chardet-2.1.1.ebuild,v 1.2 2013/01/16 11:33:03 zmedico Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Character encoding auto-detection in Python."
HOMEPAGE="http://chardet.feedparser.org/ http://code.google.com/p/chardet/"
SRC_URI="mirror://pypi/c/chardet/chardet-2.1.1.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install
	use doc && dohtml -r "${S}/docs/"
	python_convert_shebangs -r 2 .
}
