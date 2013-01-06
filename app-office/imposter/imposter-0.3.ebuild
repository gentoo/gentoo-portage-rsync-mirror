# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/imposter/imposter-0.3.ebuild,v 1.8 2012/05/03 20:00:39 jdhore Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Imposter is a standalone viewer for the presentations created by OpenOffice.org Impress software"
HOMEPAGE="http://imposter.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="iksemel nls"

RDEPEND=">=x11-libs/gtk+-2.4:2
	iksemel? ( dev-libs/iksemel )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	# Patch by Recai OktaÅŸ <roktas@omu.edu.tr>, backported from CVS...
	epatch "${FILESDIR}"/${P}-ignore-modifiers.patch
}

src_configure() {
	# FIXME. Iksemel is automagic depend.
	econf --disable-dependency-tracking $(use_enable nls)
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
