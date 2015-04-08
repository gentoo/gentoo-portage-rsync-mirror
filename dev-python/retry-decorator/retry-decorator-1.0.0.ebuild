# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/retry-decorator/retry-decorator-1.0.0.ebuild,v 1.5 2015/03/08 23:58:14 pacho Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Decorator for retrying when exceptions occur"
HOMEPAGE="https://github.com/pnpnpn/retry-decorator"
SRC_URI="https://github.com/pnpnpn/retry-decorator/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( README.rst )
