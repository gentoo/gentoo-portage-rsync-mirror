# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/shortuuid/shortuuid-0.4.2.ebuild,v 1.2 2014/06/30 04:05:15 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A generator library for concise, unambiguous and URL-safe UUIDs"
HOMEPAGE="https://pypi.python.org/pypi/shortuuid"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
