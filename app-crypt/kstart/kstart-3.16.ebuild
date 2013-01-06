# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kstart/kstart-3.16.ebuild,v 1.4 2011/05/24 07:49:34 tomka Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Modified versions of kinit for refreshing kerberos tickets
automatically"
HOMEPAGE="http://www.eyrie.org/~eagle/software/kstart"
SRC_URI="http://archives.eyrie.org/software/kerberos/${P}.tar.gz"

LICENSE="|| ( MIT Stanford ISC )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="afs"

DEPEND="virtual/krb5
		afs? ( net-fs/openafs )"
RDEPEND="$DEPEND"

src_configure() {
	econf \
		--disable-k4start \
		--enable-reduced-depends \
		"$(use_with afs)" \
		"$(use_enable afs setpag)"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	doman k5start.1 krenew.1 || die
	dodoc README NEWS TODO || die
}
