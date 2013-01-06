# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/speaklater/speaklater-1.2.ebuild,v 1.1 2010/12/14 22:24:38 rafaelmartins Exp $

EAPI=3
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Lazy strings for Python"
HOMEPAGE="https://github.com/mitsuhiko/speaklater"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	testing() {
		"$(PYTHON)" "${S}/speaklater.py" || die 'test failed.'
	}
	python_execute_function testing
}
