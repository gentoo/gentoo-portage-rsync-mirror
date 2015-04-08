# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xcffib/xcffib-0.2.0.ebuild,v 1.1 2015/02/25 17:30:19 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="A drop in replacement for xpyb, an XCB python binding"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="http://github.com/tych0/xcffib"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="x11-libs/libxcb"

RDEPEND="
	>=dev-python/cffi-0.8.2:=[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	${COMMON_DEPEND}"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${COMMON_DEPEND}"
