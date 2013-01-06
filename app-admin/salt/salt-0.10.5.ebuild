# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/salt/salt-0.10.5.ebuild,v 1.2 2012/11/29 11:39:19 mgorny Exp $

EAPI=4

PYTHON_COMPAT="python2_6 python2_7 python3_1 python3_2"

inherit eutils python-distutils-ng

DESCRIPTION="Salt is a remote execution and configuration manager."
HOMEPAGE="http://saltstack.org/"
SRC_URI="mirror://github/saltstack/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+jinja ldap libvirt mongodb mysql openssl redis"

DEPEND=""
RDEPEND="${DEPEND}
		>=dev-python/pyzmq-2.1.9
		dev-python/msgpack
		dev-python/pyyaml
		dev-python/m2crypto
		dev-python/pycrypto
		dev-python/pycryptopp
		ldap? ( dev-python/python-ldap )
		openssl? ( dev-python/pyopenssl )
		jinja? ( dev-python/jinja )
		libvirt? ( app-emulation/libvirt[python] )
		mongodb? ( dev-python/pymongo )
		mysql? ( dev-python/mysql-python )
		redis? ( dev-python/redis-py )"

# Tests try to remove system files (bug #437268).
RESTRICT=test

src_prepare() {
	sed -i '/install_requires=/ d' setup.py || die "sed failed"

	python-distutils-ng_src_prepare
}

src_install() {
	python-distutils-ng_src_install

	for s in minion master syndic; do
		newinitd "${FILESDIR}"/${s}-initd-1 salt-${s}
		newconfd "${FILESDIR}"/${s}-confd-1 salt-${s}
	done

	# install the config template files
	dodir /etc/${PN}
	for conf in conf/*.template; do
		sed '1 d' ${conf} > "${D}"/etc/${PN}/"$(basename "${conf%.template}")" \
			|| die "sed failed"
	done

	dodoc README.rst AUTHORS
}

python_test() {
	./setup.py test || die
}
