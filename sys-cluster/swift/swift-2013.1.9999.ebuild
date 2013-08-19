# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/swift/swift-2013.1.9999.ebuild,v 1.2 2013/08/19 03:30:25 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils git-2 linux-info

DESCRIPTION="A highly available, distributed, eventually consistent object/blob store"
HOMEPAGE="https://launchpad.net/swift"
EGIT_REPO_URI="https://github.com/openstack/swift.git"
EGIT_BRANCH="stable/grizzly"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="proxy account container object test +memcache"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/nose[${PYTHON_USEDEP}]
				dev-python/coverage[${PYTHON_USEDEP}]
				dev-python/nosexcover
				dev-python/openstack-nose-plugin[${PYTHON_USEDEP}]
				dev-python/nosehtmloutput[${PYTHON_USEDEP}]
				=dev-python/pep8-1.3.3
				>=dev-python/mock-0.8.0[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}] )"

RDEPEND="dev-python/eventlet[${PYTHON_USEDEP}]
		dev-python/greenlet[${PYTHON_USEDEP}]
		dev-python/netifaces
		dev-python/pastedeploy[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]
		dev-python/pyxattr[${PYTHON_USEDEP}]
		dev-python/configobj[${PYTHON_USEDEP}]
		>=dev-python/webob-1.0.8[${PYTHON_USEDEP}]
		<dev-python/webob-1.3[${PYTHON_USEDEP}]
		dev-python/python-swiftclient[${PYTHON_USEDEP}]
		memcache? ( net-misc/memcached )
		net-misc/rsync[xattr]"

REQUIRED_USE="|| ( proxy account container object )"

CONFIG_CHECK="~EXT3_FS_XATTR ~SQUASHFS_XATTR ~CIFS_XATTR ~JFFS2_FS_XATTR
~TMPFS_XATTR ~UBIFS_FS_XATTR ~EXT2_FS_XATTR ~REISERFS_FS_XATTR ~EXT4_FS_XATTR
~ZFS"

src_test () {
	sh .unittests || die
}

pkg_setup() {
	enewuser swift
	enewgroup swift
}

src_prepare() {
	sed -i 's/xattr/pyxattr/g' "${S}/swift.egg-info/requires.txt"
	sed -i 's/xattr/pyxattr/g' "${S}/tools/pip-requires"
}

python_install() {
	distutils-r1_python_install
	keepdir /etc/swift
	insinto /etc/swift

	newins "etc/swift.conf-sample" "swift.conf"
	newins "etc/swift-bench.conf-sample" "swift-bench.conf-sample"
	newins "etc/rsyncd.conf-sample" "rsyncd.conf"
	newins "etc/mime.types-sample" "mime.types-sample"
	newins "etc/memcache.conf-sample" "memcache.conf-sample"
	newins "etc/drive-audit.conf-sample" "drive-audit.conf-sample"
	newins "etc/dispersion.conf-sample" "dispersion.conf-sample"

	if use proxy; then
		newinitd "${FILESDIR}/swift-proxy.initd" "swift-proxy"
		newins "etc/proxy-server.conf-sample" "proxy-server.conf"
		if use memcache; then
			sed -i '/depend/a\
    need memcached' "${D}/etc/init.d/swift-proxy"
		fi
	fi
	if use account; then
		newinitd "${FILESDIR}/swift-account.initd" "swift-account"
		newins "etc/account-server.conf-sample" "account-server.conf"
	fi
	if use container; then
		newinitd "${FILESDIR}/swift-container.initd" "swift-container"
		newins "etc/container-server.conf-sample" "container-server.conf"
	fi
	if use object; then
		newinitd "${FILESDIR}/swift-object.initd" "swift-object"
		newins "etc/object-server.conf-sample" "object-server.conf"
		newins "etc/object-expirer.conf-sample" "object-expirer.conf"
	fi

	fowners swift:swift "/etc/swift" || die "fowners failed"
}

pkg_postinst() {
	elog "Openstack swift will default to using insecure http unless a"
	elog "certificate is created in /etc/swift/cert.crt and the associated key"
	elog "in /etc/swift/cert.key.  These can be created with the following:"
	elog "  * cd /etc/swift"
	elog "  * openssl req -new -x509 -nodes -out cert.crt -keyout cert.key"
}

#src_install()
#{
#	distutils_src_install
#
#	dodir "/var/run/swift"
#
#	if use proxy-server; then
#		newinitd "${FILESDIR}/swift-proxy-server.initd" swift-proxy-server
#	fi
#
#	if use storage-server; then
#		newinitd "${FILESDIR}/swift-storage-server.initd" swift-storage-server
#		newconfd "${FILESDIR}/swift-storage-server.confd" swift-storage-server
#	fi
#}
