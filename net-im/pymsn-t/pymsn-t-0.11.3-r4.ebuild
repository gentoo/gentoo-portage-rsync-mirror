# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pymsn-t/pymsn-t-0.11.3-r4.ebuild,v 1.1 2013/09/14 23:05:48 hanno Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )
inherit eutils python-single-r1

MY_P="${P/pymsn-t/pymsnt}"
DESCRIPTION="Python based jabber transport for MSN"
HOMEPAGE="http://delx.net.au/projects/pymsnt/"
SRC_URI="http://delx.net.au/projects/pymsnt/tarballs/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-im/jabber-base"
RDEPEND="${DEPEND}
	dev-python/twisted-core[${PYTHON_USEDEP}]
	dev-python/twisted-words[${PYTHON_USEDEP}]
	dev-python/twisted-web[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]"

src_prepare() {
	epatch "${FILESDIR}/${P}-protocol-version.patch"
	epatch "${FILESDIR}/${P}-unexpected-xfr.patch"
	epatch "${FILESDIR}/${P}-remove-pid.patch"
	epatch "${FILESDIR}/${P}-delete-reactor.patch"
	epatch "${FILESDIR}/${P}-use-non-deprecated-hashlib.patch"
	epatch "${FILESDIR}/${P}-imaging-pillow.patch"
	epatch "${FILESDIR}/${P}-twisted13.patch"
}

src_install() {
	python_moduleinto ${PN}
	cp PyMSNt.py ${PN}.py
	python_domodule ${PN}.py data src

	insinto /etc/jabber
	newins config-example.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	fperms 755 "$(python_get_sitedir)/${PN}/${PN}.py"
	sed -i \
		-e "s:<!-- <spooldir>[^\<]*</spooldir> -->:<spooldir>/var/spool/jabber</spooldir>:" \
		-e "s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		-e "s:<host>[^\<]*</host>:<host>example.org</host>:" \
		-e "s:<jid>msn</jid>:<jid>msn.example.org</jid>:" \
		"${ED}/etc/jabber/${PN}.xml"

	newinitd "${FILESDIR}/${PN}-initd-r1" ${PN}
	sed -i -e "s:INSPATH:$(python_get_sitedir)/${PN}:" "${ED}/etc/init.d/${PN}"
	python_fix_shebang "${D}$(python_get_sitedir)/${PN}"
}
