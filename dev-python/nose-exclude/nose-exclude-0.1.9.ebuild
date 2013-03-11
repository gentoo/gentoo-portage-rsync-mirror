# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose-exclude/nose-exclude-0.1.9.ebuild,v 1.1 2013/03/11 00:27:15 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="Exclude specific directories from nosetests runs."
HOMEPAGE="http://bitbucket.org/kgrandis/nose-exclude"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/nose[${PYTHON_USEDEP}]"
