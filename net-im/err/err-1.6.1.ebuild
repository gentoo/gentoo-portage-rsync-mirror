# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/err/err-1.6.1.ebuild,v 1.2 2013/04/17 07:24:39 pinkbyte Exp $

EAPI=5

DISTUTILS_SRC_TEST="setup.py"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils user

DESCRIPTION="Plugin based XMPP chatbot designed to be easily deployable, extensible and maintainable"
HOMEPAGE="http://gbin.github.com/err/"

SRC_URI="mirror://pypi/e/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="qt4 +plugins"

DEPEND="dev-python/setuptools"
# NOTES:
# 1. It has bundled libs - for example exrex(see 'errbot/bundled' subfolder)
RDEPEND="dev-python/dnspython
	dev-python/flask
	dev-python/jinja
	dev-python/pyfire
	dev-python/python-daemon
	dev-python/simplejson
	dev-python/xmpppy
	<dev-python/yapsy-1.10
	qt4? ( dev-python/pyside[X,webkit] )
	plugins? ( dev-vcs/git )"

pkg_setup() {
	python_pkg_setup
	ebegin "Creating err group and user"
	enewgroup 'err'
	enewuser 'err' -1 -1 -1 'err'
	eend ${?}
}

src_prepare() {
	# Remove configparser from requirements
	sed -i "s/'configparser', //" setup.py || die "remove configparser from setup.py failed"
	distutils_src_prepare
}

src_install() {
	# Upstream requires images to be in site-packages directory,
	# butdoes not install them at all!
	install_svgs() {
		insinto "$(python_get_sitedir)"/errbot
		doins errbot/*.svg
	}
	distutils_src_install

	newinitd "${FILESDIR}"/errd.initd errd
	newconfd "${FILESDIR}"/errd.confd errd

	dodir /etc/${PN}
	dodir /var/lib/${PN}
	keepdir /var/log/${PN}
	fowners -R err:err /var/lib/${PN}
	fowners -R err:err /var/log/${PN}

	insinto /etc/${PN}
	newins errbot/config-template.py config.py

	use qt4 && python_execute_function install_svgs
}
