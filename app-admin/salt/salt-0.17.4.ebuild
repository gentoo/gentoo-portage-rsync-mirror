# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/salt/salt-0.17.4.ebuild,v 1.1 2013/12/12 23:26:17 chutzpah Exp $

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
		sys-apps/pciutils
		mako? ( dev-python/mako[${PYTHON_USEDEP}] )
		ldap? ( dev-python/python-ldap[${PYTHON_USEDEP}] )
		openssl? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )
		libvirt? ( || (
			dev-python/libvirt-python[${PYTHON_USEDEP}]
			app-emulation/libvirt[python,${PYTHON_USEDEP}]
			)
		)
		mongodb? ( dev-python/pymongo[${PYTHON_USEDEP}] )
		mysql? ( dev-python/mysql-python[${PYTHON_USEDEP}] )
		redis? ( dev-python/redis-py[${PYTHON_USEDEP}] )"
DEPEND="test? (
			dev-python/pip
			dev-python/virtualenv
			dev-python/SaltTesting
			${RDEPEND}
		)"

PATCHES=("${FILESDIR}/${PN}-0.17.1-tests-nonroot.patch")
DOCS=(README.rst AUTHORS)

python_prepare() {
	sed -i '/install_requires=/ d' setup.py || die "sed failed"
}

python_install_all() {
	distutils-r1_python_install_all

	for s in minion master syndic; do
		newinitd "${FILESDIR}"/${s}-initd-1 salt-${s}
		newconfd "${FILESDIR}"/${s}-confd-1 salt-${s}
	done

	insinto /etc/${PN}
	doins conf/*
}

python_test() {
	# testsuite likes lots of files
	ulimit -n 3072
	SHELL="/bin/bash" TMPDIR=/tmp ./tests/runtests.py --unit-tests --no-report || die
}
