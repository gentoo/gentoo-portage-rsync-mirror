# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/manifestdestiny/manifestdestiny-0.6.ebuild,v 1.1 2013/11/26 05:34:35 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7}  pypy2_0 )

inherit distutils-r1

MY_PN="ManifestDestiny"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Universal manifests for Mozilla test harnesses"
HOMEPAGE="https://wiki.mozilla.org/Auto-tools/Projects/ManifestDestiny http://pypi.python.org/pypi/ManifestDestiny"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MPL-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
