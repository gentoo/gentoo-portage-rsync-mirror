# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/email2trac/email2trac-2.6.0.ebuild,v 1.1 2012/09/01 00:41:44 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Utilites to convert emails into trac objects"
HOMEPAGE="https://subtrac.sara.nl/oss/email2trac/"
SRC_URI="ftp://ftp.sara.nl/pub/outgoing/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="=www-apps/trac-0.12*"

pkg_setup() {
	einfo "You can set the following variables in make.conf:"
	einfo " - EMAIL2TRAC_TRAC_USER (default: apache)"
	einfo " - EMAIL2TRAC_MTA_USER (default: nobody)"

	python_pkg_setup
}

src_prepare() {
	sed -i -e "/^CFLAGS/s:=:&${CFLAGS} :" \
		-e "s:\$(CC):& ${LDFLAGS} :" \
		Makefile.in
}

src_configure() {
	econf --sysconfdir=/etc/${PN}/ \
		--with-trac_user=${EMAIL2TRAC_TRAC_USER:-apache} \
		--with-mta_user=${EMAIL2TRAC_MTA_USER:-nobody}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
	python_convert_shebangs -r 2 "${D}"
}
