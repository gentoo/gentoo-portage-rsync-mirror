# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pyicq-t/pyicq-t-0.8.1.5-r1.ebuild,v 1.3 2013/04/27 22:37:04 ago Exp $

EAPI="5"
PYTHON_DEPEND="2"
inherit eutils python

MY_P="${P/pyicq-t/pyicqt}"

DESCRIPTION="Python based jabber transport for ICQ"
HOMEPAGE="http://code.google.com/p/pyicqt/"
SRC_URI="http://pyicqt.googlecode.com/files/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="webinterface"

DEPEND="net-im/jabber-base"
RDEPEND="${DEPEND}
	>=dev-python/twisted-2.2.0
	>=dev-python/twisted-words-0.1.0
	>=dev-python/twisted-web-0.5.0
	webinterface? ( >=dev-python/nevow-0.4.1 )
	>=dev-python/imaging-1.1"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-python26-warnings.diff"
}

src_install() {
	local inspath

	inspath=$(python_get_sitedir)/${PN}
	insinto ${inspath}
	doins -r data src tools
	newins PyICQt.py ${PN}.py

	insinto /etc/jabber
	newins config_example.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	fperms 755 "$(python_get_sitedir)/${PN}/pyicq-t.py"
	sed -i \
		-e "s:<spooldir>[^\<]*</spooldir>:<spooldir>/var/spool/jabber</spooldir>:" \
		-e "s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		"${ED}/etc/jabber/${PN}.xml"

	newinitd "${FILESDIR}/${PN}-0.8-initd-r1" ${PN}
	sed -i -e "s:INSPATH:${inspath}:" "${ED}/etc/init.d/${PN}"
	python_convert_shebangs ${PYTHON_ABI} "${ED}$(python_get_sitedir)/${PN}/pyicq-t.py"
}

pkg_postinst() {
	python_mod_optimize ${PN}

	elog "A sample configuration file has been installed in /etc/jabber/${PN}.xml."
	elog "Please edit it and the configuration of your Jabber server to match."

	ewarn "If you are storing user accounts in MySQL and are upgrading from a "
	ewarn "version older than 0.8.1, then you will need to run the following "
	ewarn "command to create some new tables:"
	ewarn "	 mysql -u user_name -p pyicqt < $(python_get_sitedir)/${PN}/tools/db-setup.mysql"

	elog  "These instructions along with a list of new config variables are "
	elog  "available at: http://code.google.com/p/pyicqt/wiki/Upgrade"
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
