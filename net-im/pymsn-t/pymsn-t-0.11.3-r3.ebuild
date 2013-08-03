# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pymsn-t/pymsn-t-0.11.3-r3.ebuild,v 1.5 2013/08/03 09:45:38 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit eutils multilib python

MY_PN="pymsnt"
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Python based jabber transport for MSN"
HOMEPAGE="http://msn-transport.jabberstudio.org/"
SRC_URI="http://msn-transport.jabberstudio.org/tarballs/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="net-im/jabber-base"
RDEPEND="${DEPEND}
	>=dev-python/twisted-core-2.5.0
	>=dev-python/twisted-words-0.5.0
	>=dev-python/twisted-web-0.7.0
	>=dev-python/imaging-1.1"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-protocol-version.patch"
	epatch "${FILESDIR}/${P}-unexpected-xfr.patch"
	epatch "${FILESDIR}/${P}-remove-pid.patch"
	epatch "${FILESDIR}/${P}-delete-reactor.patch"
	epatch "${FILESDIR}/${P}-use-non-deprecated-hashlib.patch"
}

src_install() {
	local inspath

	inspath=$(python_get_sitedir)/${PN}
	insinto ${inspath}
	doins -r data src
	newins PyMSNt.py ${PN}.py

	insinto /etc/jabber
	newins config-example.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	dosed \
		"s:<!-- <spooldir>[^\<]*</spooldir> -->:<spooldir>/var/spool/jabber</spooldir>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<host>[^\<]*</host>:<host>example.org</host>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<jid>msn</jid>:<jid>msn.example.org</jid>:" \
		/etc/jabber/${PN}.xml

	newinitd "${FILESDIR}/${PN}-initd" ${PN}
	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN}
}

pkg_postinst() {
	python_mod_optimize ${PN}

	elog "A sample configuration file has been installed in /etc/jabber/${PN}.xml."
	elog "Please edit it and the configuration of your Jabber server to match."
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
