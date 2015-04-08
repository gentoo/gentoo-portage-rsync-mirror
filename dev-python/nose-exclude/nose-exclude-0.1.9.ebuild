# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose-exclude/nose-exclude-0.1.9.ebuild,v 1.8 2015/03/09 00:04:52 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Exclude specific directories from nosetests runs"
HOMEPAGE="http://bitbucket.org/kgrandis/nose-exclude"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/nose[${PYTHON_USEDEP}]"
