# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zopfli/zopfli-1.0.0_p20140705.ebuild,v 1.2 2014/08/14 12:23:57 pinkbyte Exp $

EAPI=5

inherit eutils toolchain-funcs vcs-snapshot

DESCRIPTION="Compression library programmed in C to perform very good, but slow, deflate or zlib compression"
HOMEPAGE="https://github.com/Hello71/zopfli/"
SRC_URI="https://github.com/Hello71/zopfli/archive/1c07f374419ccb352412fd6403acc2b59ab6cce7.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/1"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"

src_prepare() {
	tc-export CC CXX

	epatch_user
}

src_install() {
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" libdir="${EPREFIX}/usr/$(get_libdir)" install
	dodoc CONTRIBUTORS README README.${PN}png
}
