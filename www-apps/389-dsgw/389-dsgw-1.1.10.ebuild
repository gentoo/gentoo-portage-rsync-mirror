# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/389-dsgw/389-dsgw-1.1.10.ebuild,v 1.1 2013/03/14 17:50:00 lxnay Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="389 Directory Server Gateway Web Application"
HOMEPAGE="http://port389.org/"
SRC_URI="http://directory.fedoraproject.org/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +adminserver"

DEPEND="adminserver? ( net-nds/389-admin )
	dev-libs/nspr
	dev-libs/nss
	dev-libs/cyrus-sasl
	dev-libs/icu
	dev-libs/389-adminutil
	net-nds/openldap"

RDEPEND="${DEPEND}
	dev-perl/perl-mozldap
	virtual/perl-CGI"

src_prepare() {
	# as per 389 documentation, when 64bit, export USE_64
	use amd64 && export USE_64=1
	eautoreconf
}

src_configure() {
	econf $(use_enable debug) \
		$(use_with adminserver) \
		--with-adminutil=/usr \
		--with-fhs \
		--with-openldap || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
