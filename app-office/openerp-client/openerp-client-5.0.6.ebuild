# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openerp-client/openerp-client-5.0.6.ebuild,v 1.5 2011/03/31 17:14:34 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.openerp.com/"
SRC_URI="http://www.openerp.com/download/stable/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

CDEPEND="dev-python/matplotlib
		dev-python/egenix-mx-base
		x11-libs/hippo-canvas[python]"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install
	rm "${ED}usr/bin/openerp-client"
	dobin "${FILESDIR}/openerp-client"
}
