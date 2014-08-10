# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cdiff/cdiff-0.9.1.ebuild,v 1.5 2014/08/10 21:26:08 slyfox Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2} )
DOCS=( CHANGES README.rst )

inherit distutils-r1

DESCRIPTION="Colored, side-by-side diff terminal viewer"
HOMEPAGE="https://github.com/ymattw/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"

DEPEND="!app-misc/colordiff
	dev-python/setuptools[${PYTHON_USEDEP}]
	sys-apps/less"
RDEPEND="${DEPEND}"
