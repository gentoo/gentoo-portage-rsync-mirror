# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nosexcover/nosexcover-1.0.7.ebuild,v 1.2 2013/01/02 20:02:05 prometheanfire Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Extends nose.plugins.cover to add Cobertura-style XML reports"
HOMEPAGE="https://github.com/cmheisel/nose-xcover/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
		dev-python/nose
		dev-python/coverage"
RDEPEND="${DEPEND}"
