# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lksctp-tools/lksctp-tools-1.0.11-r1.ebuild,v 1.7 2012/03/19 19:10:56 armin76 Exp $

EAPI=4

inherit eutils multilib flag-o-matic

DESCRIPTION="Tools for Linux Kernel Stream Control Transmission Protocol implementation"
HOMEPAGE="http://lksctp.sourceforge.net/"
SRC_URI="mirror://sourceforge/lksctp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="kernel_linux static-libs"

# This is only supposed to work with Linux to begin with.
DEPEND=">=sys-kernel/linux-headers-2.6"
RDEPEND=""

REQUIRED_USE="kernel_linux"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.8-prefix.patch #181602
}

src_configure() {
	append-flags -fno-strict-aliasing

	econf $(use_enable static-libs static) \
		--enable-shared
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README ROADMAP doc/*txt || die

	newdoc src/withsctp/README README.withsctp || die

	# Don't install static library or libtool file, since this is used
	# only as preloadable library.
	use static-libs && rm "${D}"/usr/$(get_libdir)/${PN}/*.a

	find "${D}" -name '*.la' -delete || die
}
