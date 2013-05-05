# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/salt/salt-0.15.0-r1.ebuild,v 1.1 2013/05/04 23:08:49 chutzpah Exp $

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
IUSE="ldap libvirt mako mongodb mysql openssl redis test"

RDEPEND=">=dev-python/pyzmq-2.1.9[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/m2crypto[${PYTHON_USEDEP}]
		dev-python/pycrypto[${PYTHON_USEDEP}]
		dev-python/pycryptopp[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
		mako? ( dev-python/mako[${PYTHON_USEDEP}] )
		ldap? ( dev-python/python-ldap[${PYTHON_USEDEP}] )
		openssl? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )
		libvirt? ( app-emulation/libvirt[python] )
		mongodb? ( dev-python/pymongo[${PYTHON_USEDEP}] )
		mysql? ( dev-python/mysql-python[${PYTHON_USEDEP}] )
		redis? ( dev-python/redis-py[${PYTHON_USEDEP}] )"
DEPEND="test? (
			dev-python/virtualenv
			${RDEPEND}
		)"

python_prepare() {
	sed -i '/install_requires=/ d' setup.py || die "sed failed"
}

python_install_all() {
	for s in minion master syndic; do
		newinitd "${FILESDIR}"/${s}-initd-1 salt-${s}
		newconfd "${FILESDIR}"/${s}-confd-1 salt-${s}
	done

	insinto /etc/${PN}
	doins conf/*

	dodoc README.rst AUTHORS
}

python_test() {
	# testsuite likes lots of files
	ulimit -n 3072
	SHELL="/bin/bash" TMPDIR=/tmp ./tests/runtests.py --unit-tests --no-report || die
}
