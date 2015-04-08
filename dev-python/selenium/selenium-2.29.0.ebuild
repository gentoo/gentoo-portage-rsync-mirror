# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/selenium/selenium-2.29.0.ebuild,v 1.4 2013/09/24 22:43:08 vapier Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="a Python language binding for Selenium Remote Control (version 1.0 and 2.0)"
HOMEPAGE="http://pypi.python.org/pypi/selenium/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc"
LICENSE="Apache-2.0"
SLOT="0"

DOCS=( py/CHANGES py/README )
DISTUTILS_IN_SOURCE_BUILD=1
QA_PREBUILT="/usr/lib*/python*/site-packages/${PN}/webdriver/firefox/*/x_ignore_nofocus.so"
