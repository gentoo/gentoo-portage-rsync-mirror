# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-oembed/python-oembed-0.2.1.ebuild,v 1.1 2012/05/13 20:28:37 rafaelmartins Exp $

EAPI=4
DISTUTILS_SRC_TEST="nosetests"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A Python library that implements an OEmbed consumer."
HOMEPAGE="http://pypi.python.org/pypi/python-oembed"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"
