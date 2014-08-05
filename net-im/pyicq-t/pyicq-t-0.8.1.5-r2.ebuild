# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pyicq-t/pyicq-t-0.8.1.5-r2.ebuild,v 1.2 2014/08/05 18:34:14 mrueg Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )
inherit eutils python-single-r1

MY_P="${P/pyicq-t/pyicqt}"

DESCRIPTION="Python based jabber transport for ICQ"
HOMEPAGE="http://code.google.com/p/pyicqt/"
SRC_URI="http://pyicqt.googlecode.com/files/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="webinterface"

DEPEND="net-im/jabber-base"
RDEPEND="${DEPEND}
	>=dev-python/twisted-core-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-words-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-web-0.5.0[${PYTHON_USEDEP}]
	webinterface? ( >=dev-python/nevow-0.4.1[${PYTHON_USEDEP}] )
	virtual/python-imaging[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/${P}-python26-warnings.diff"
	"${FILESDIR}/${P}-pillow-imaging.patch"
)

src_install() {
	python_moduleinto ${PN}
	cp PyICQt.py pyicq-t.py || die
	python_domodule pyicq-t.py data tools src

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
	sed -i -e "s:INSPATH:$(python_get_sitedir):" "${ED}/etc/init.d/${PN}"
	python_fix_shebang "${D}$(python_get_sitedir)/${PN}"
}
