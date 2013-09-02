# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ordereddict/ordereddict-1.1.ebuild,v 1.1 2013/09/02 16:05:01 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 )

inherit distutils-r1

DESCRIPTION="A drop-in substitute for Py2.7's new collections.OrderedDict"
HOMEPAGE="https://pypi.python.org/pypi/ordereddict"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
