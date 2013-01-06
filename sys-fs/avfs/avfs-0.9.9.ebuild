# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/avfs/avfs-0.9.9.ebuild,v 1.12 2012/09/30 18:02:06 armin76 Exp $

EAPI=3
inherit eutils linux-info

DESCRIPTION="AVFS is a virtual filesystem that allows browsing of compressed files."
HOMEPAGE="http://sourceforge.net/projects/avf"
SRC_URI="mirror://sourceforge/avf/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 x86"
IUSE="static-libs +lzma"

RDEPEND=">=sys-fs/fuse-2.4
	lzma? ( app-arch/xz-utils )"
DEPEND="${RDEPEND}
	lzma? ( virtual/pkgconfig )"

pkg_setup() {
	kernel_is lt 2 6 && die "Must have a version 2.6 kernel. Cannot continue. :("
}

src_prepare() {
	# Fixes bug #258295
	epatch "${FILESDIR}/${PN}-0.9.8-gcc43_fix_open_missing_mode.patch"
}

src_configure() {
	econf \
		--enable-fuse \
		--enable-library \
		--enable-shared \
		$(use_enable static-libs static) \
		$(use_with lzma xz)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# remove cruft
	rm -f "${D}"/bin/davpass "${D}"/bin/ftppass || die "rm failed"
	# install docs
	cd "${S}"/doc
	dodoc api-overview background FORMAT INSTALL.* README.avfs-fuse || die "dodoc failed"
	cd ..
	dodoc AUTHORS ChangeLog COPYING* INSTALL NEWS README TODO || die "dodoc failed"
	docinto scripts
	dodoc scripts/avfs* scripts/*pass scripts/*mountavfs || die "dodoc failed"
	dosym /usr/lib/avfs/extfs/README /usr/share/doc/${PF}/README.extfs || die "dosym failed"
}

pkg_postinst() {
	einfo "This version of AVFS includes FUSE support. It is user-based."
	einfo "To execute:"
	einfo "1) as user, mkdir ~/.avfs"
	einfo "2) make sure fuse is either compiled into the kernel OR"
	einfo "   modprobe fuse or add to startup."
	einfo "3) run mountavfs"
	einfo "To unload daemon, type umountavfs"
	echo
	einfo "READ the documentation! Enjoy :)"
}
