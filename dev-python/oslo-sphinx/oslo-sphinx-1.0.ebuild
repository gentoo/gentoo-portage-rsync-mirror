# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oslo-sphinx/oslo-sphinx-1.0.ebuild,v 1.2 2014/03/30 09:30:06 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Theme and extension support for Sphinx documentation from the OpenStack project."
HOMEPAGE="https://pypi.python.org/pypi/oslo.config"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.sphinx/oslo.sphinx-${PV}.tar.gz"
S="${WORKDIR}/oslo.sphinx-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/pbr[${PYTHON_USEDEP}]
	test? ( >=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
		<dev-python/hacking-0.8[${PYTHON_USEDEP}] )"
