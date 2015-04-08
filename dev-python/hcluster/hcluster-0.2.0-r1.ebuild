# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hcluster/hcluster-0.2.0-r1.ebuild,v 1.1 2013/06/22 16:12:19 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python hierarchical clustering package for Scipy"
HOMEPAGE="http://code.google.com/p/scipy-cluster/ http://pypi.python.org/pypi/hcluster"
SRC_URI="http://scipy-cluster.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/matplotlib[${PYTHON_USEDEP}]"

# Tests need X display with matplotlib.
RESTRICT="test"
