# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/salt/salt-0.11.0.ebuild,v 1.2 2012/12/19 00:40:55 chutzpah Exp $

EAPI=5

PYTHON_COMPAT=(python{2_6,2_7})

inherit eutils distutils-r1

DESCRIPTION="Salt is a remote execution and configuration manager."
HOMEPAGE="http://saltstack.org/"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/${PN}stack/${PN}.git"
	EGIT_BRANCH="develop"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="ldap libvirt mongodb mysql openssl redis test"

RDEPEND=">=dev-python/pyzmq-2.1.9
		dev-python/msgpack
		dev-python/pyyaml
		dev-python/m2crypto
		dev-python/pycrypto
		dev-python/pycryptopp
		dev-python/jinja
		ldap? ( dev-python/python-ldap )
		openssl? ( dev-python/pyopenssl )
		libvirt? ( app-emulation/libvirt[python] )
		mongodb? ( dev-python/pymongo )
		mysql? ( dev-python/mysql-python )
		redis? ( dev-python/redis-py )"
DEPEND="test? (
			dev-python/virtualenv
			${RDEPEND}
		)"

src_prepare() {
	sed -i '/install_requires=/ d' setup.py || die "sed failed"

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install

	for s in minion master syndic; do
		newinitd "${FILESDIR}"/${s}-initd-1 salt-${s}
		newconfd "${FILESDIR}"/${s}-confd-1 salt-${s}
	done

	dodoc README.rst AUTHORS
}

python_test() {
	SHELL="/bin/bash" ./tests/runtests.py --unit-tests --no-report || die
}
