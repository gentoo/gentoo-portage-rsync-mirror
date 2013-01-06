# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/roman/roman-1.4.0.ebuild,v 1.1 2012/05/18 12:01:47 xarthisius Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="An Integer to Roman numerals converter"
HOMEPAGE="http://pypi.python.org/pypi/roman/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!<dev-python/docutils-0.9"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME=${PN}.py
