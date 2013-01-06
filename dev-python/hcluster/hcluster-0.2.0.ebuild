# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hcluster/hcluster-0.2.0.ebuild,v 1.3 2012/02/23 09:08:34 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="Python hierarchical clustering package for Scipy"
HOMEPAGE="http://code.google.com/p/scipy-cluster/ http://pypi.python.org/pypi/hcluster"
SRC_URI="http://scipy-cluster.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/matplotlib
	dev-python/numpy"
RDEPEND="${DEPEND}"

# Tests need X display with matplotlib.
RESTRICT="test"
