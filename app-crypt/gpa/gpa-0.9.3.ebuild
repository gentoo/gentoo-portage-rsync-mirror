# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.9.3.ebuild,v 1.6 2012/12/01 19:34:37 armin76 Exp $

EAPI=4

DESCRIPTION="The GNU Privacy Assistant (GPA) is a graphical user interface for GnuPG"
HOMEPAGE="http://gpa.wald.intevation.org"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.10.0:2
	>=dev-libs/libgpg-error-1.4
	>=dev-libs/libassuan-1.1.0
	>=app-crypt/gnupg-2
	>=app-crypt/gpgme-1.2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	# force --libexecdir so that it doesn't expand to
	# ${exec_prefix}/libexec instead.
	econf \
		--libexecdir=/usr/libexec \
		--with-gpgme-prefix=/usr \
		--with-libassuan-prefix=/usr \
		$(use_enable nls)
}

DOCS=( AUTHORS ChangeLog README NEWS TODO )
