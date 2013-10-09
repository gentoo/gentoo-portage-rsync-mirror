# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/clens/clens-0.7.0.ebuild,v 1.4 2013/10/09 10:10:56 ulm Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

DESCRIPTION="Convenience library to aid in porting OpenBSD code to other OSes"
HOMEPAGE="https://opensource.conformal.com/wiki/clens"
SRC_URI="https://opensource.conformal.com/snapshots/${PN}/${P}.tar.gz"

LICENSE="ISC BSD BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-arc4random.patch
	tc-export CC AR
}

src_install() {
	emake DESTDIR="${D}" \
		LOCALBASE="${EPREFIX}/usr" \
		LIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		install
}
