# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/dirmngr/dirmngr-1.1.0.ebuild,v 1.9 2011/06/01 14:18:21 flameeyes Exp $

EAPI="3"

DESCRIPTION="DirMngr is a daemon to handle CRL and certificate requests for GnuPG"
HOMEPAGE="http://www.gnupg.org/download/index.en.html#dirmngr"
#SRC_URI="ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.bz2"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"
#SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE="nls"

RDEPEND=">=net-nds/openldap-2.1.26
	>=dev-libs/libgpg-error-1.4
	>=dev-libs/libgcrypt-1.4.0
	>=dev-libs/libksba-1.0.2
	>=dev-libs/pth-1.3.7
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	>=dev-libs/libassuan-2
	nls? ( >=sys-devel/gettext-0.12.1 )"

src_configure() {
	econf --docdir="/usr/share/doc/${PF}" $(use_enable nls) \
		LDAPLIBS="-lldap -llber"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
