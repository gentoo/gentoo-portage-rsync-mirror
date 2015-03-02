# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/diamond/diamond-4.0.ebuild,v 1.1 2015/03/01 23:09:12 grobian Exp $

EAPI=5

if [[ ${PV} = 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/python-diamond/Diamond.git"
else
	SRC_URI="https://github.com/python-diamond/Diamond/archive/v${PV}.tar.gz -> python-diamond-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python daemon that collects and publishes system metrics"
HOMEPAGE="https://github.com/python-diamond/Diamond"

LICENSE="MIT"
SLOT="0"
IUSE="test mongo mysql snmp redis"

RDEPEND="dev-python/configobj
	dev-python/setproctitle
	mongo? ( dev-python/pymongo )
	mysql? ( dev-python/mysql-python )
	snmp? ( dev-python/pysnmp )
	redis? ( dev-python/redis-py )"
DEPEND="${RDEPEND}
	test? ( dev-python/mock )"

S=${WORKDIR}/Diamond-${PV}

src_prepare() {
	# adjust for Prefix
	sed -i \
		-e '/default="\/etc\/diamond\/diamond.conf"/s:=":="'"${EPREFIX}"':' \
		bin/diamond* \
		|| die

	distutils-r1_src_prepare
}

python_test() {
	"${PYTHON}" ./test.py || die "Tests fail with ${PYTHON}"
}

python_install() {
	export VIRTUAL_ENV=1
	distutils-r1_python_install
	mv "${ED}"/usr/etc "${ED}"/ || die
}

src_install() {
	distutils-r1_src_install
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
