# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pyaim-t/pyaim-t-0.8a.ebuild,v 1.8 2010/07/06 16:06:48 arfrever Exp $

PYTHON_DEPEND="2"

inherit eutils multilib python

DESCRIPTION="Python based jabber transport for AIM"
HOMEPAGE="http://code.google.com/p/pyaimt/"
SRC_URI="http://pyaimt.googlecode.com/files/${P}.tar.gz"

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

src_unpack() {
	unpack ${A} && cd "${S}" || die "unpack failed"

	epatch "${FILESDIR}/${PN}-0.8-twisted-2.5.patch"
}

src_install() {
	local inspath

	inspath=$(python_get_sitedir)/${PN}
	insinto ${inspath}
	doins -r data src tools
	newins PyAIMt.py ${PN}.py

	insinto /etc/jabber
	newins config_example.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	dosed \
		"s:<spooldir>[^\<]*</spooldir>:<spooldir>/var/spool/jabber</spooldir>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		/etc/jabber/${PN}.xml

	newinitd "${FILESDIR}/${PN}-0.8-initd" ${PN}
	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN}
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}

	elog "A sample configuration file has been installed in /etc/jabber/${PN}.xml."
	elog "Please edit it and the configuration of your Jabber server to match."
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/${PN}
}
