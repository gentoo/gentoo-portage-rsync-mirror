# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/emovix/emovix-0.9.0.ebuild,v 1.7 2007/12/23 18:50:36 josejx Exp $

DESCRIPTION="Micro Linux distro to boot from a CD and play every video file localized in the CD root."
HOMEPAGE="http://movix.sourceforge.net"
SRC_URI="mirror://sourceforge/movix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="win32codecs"

RDEPEND="win32codecs? ( media-libs/win32codecs )
	 virtual/cdrtools"
DEPEND="dev-lang/perl
	sys-apps/gawk"

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README* TODO
	dosym /usr/lib/win32 /usr/share/emovix/codecs
}
