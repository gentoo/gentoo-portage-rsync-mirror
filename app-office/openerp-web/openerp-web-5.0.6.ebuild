# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openerp-web/openerp-web-5.0.6.ebuild,v 1.3 2011/04/06 17:06:48 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit eutils distutils

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.openerp.com/"
SRC_URI="http://www.openerp.com/download/stable/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-python/cherrypy
	dev-python/mako
	dev-python/Babel
	dev-python/formencode
	dev-python/simplejson
	dev-python/beaker"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

S="${WORKDIR}/openerp-client-web-${PV}"

PYTHON_MODNAME="openerp"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install

	doinitd "${FILESDIR}/${PN}"
	newconfd "${FILESDIR}/openerp-web-confd" "${PN}"

	rm "${D}/usr/scripts/${PN}"
	rm "${D}/usr/config/${PN}.cfg"
}
