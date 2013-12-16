# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zopfli/zopfli-1.0.0_p20131216.ebuild,v 1.1 2013/12/16 20:27:22 pinkbyte Exp $

EAPI="5"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Compression library programmed in C to perform very good, but slow, deflate or zlib compression"
HOMEPAGE="https://github.com/Hello71/zopfli/"
SRC_URI="https://dev.gentoo.org/~pinkbyte/distfiles/snapshots/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0/1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

S="${WORKDIR}/${PN}"

src_prepare() {
	# Respect compiler
	tc-export CC CXX

	epatch_user
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" libdir="${EPREFIX}/usr/$(get_libdir)" install
	dodoc CONTRIBUTORS README README.${PN}png
}
