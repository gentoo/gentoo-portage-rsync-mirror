# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsutil/gsutil-3.37.ebuild,v 1.1 2013/12/09 07:08:06 vapier Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="command line tool for interacting with cloud storage services"
HOMEPAGE="https://github.com/GoogleCloudPlatform/gsutil"
SRC_URI="http://commondatastorage.googleapis.com/pub/${PN}_${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/boto-2.13[${PYTHON_USEDEP}]
	>=dev-python/crcmod-1.7
	>=dev-python/httplib2-0.8[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.13[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/python-gflags[${PYTHON_USEDEP}]
	dev-python/retry-decorator[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/socksipy-1.01[${PYTHON_USEDEP}]
	"

S=${WORKDIR}/${PN}

DOCS=( README.md CHANGES.md )

PATCHES=(
	"${FILESDIR}/${P}-use-friendy-version-checks.patch"
	"${FILESDIR}/${PN}-3.37-drop-http_proxy-clearing.patch"
)

python_test() {
	export BOTO_CONFIG=${FILESDIR}/dummy.boto
	${PYTHON} gslib/__main__.py test -u || die "tests failed"
}
