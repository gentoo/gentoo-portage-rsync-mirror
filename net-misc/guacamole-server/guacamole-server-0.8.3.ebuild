# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guacamole-server/guacamole-server-0.8.3.ebuild,v 1.1 2013/11/26 12:48:44 nativemad Exp $

EAPI=4

inherit eutils
DESCRIPTION="This is the proxy-daemon used by www-apps/guacamole."

HOMEPAGE="http://guacamole.sourceforge.net/"
SRC_URI="mirror://sourceforge/guacamole/${P}.tar.gz"

LICENSE="AGPL-3"

SLOT="0"

KEYWORDS="~x86"

IUSE="rdesktop vnc ssh pulseaudio vorbis"

DEPEND="x11-libs/cairo
	ssh? ( x11-libs/pango
		net-libs/libssh )
	rdesktop? ( >=net-misc/freerdp-1.1.0_beta1_p20130710 )
	vnc? ( net-libs/libvncserver
	pulseaudio? ( media-sound/pulseaudio ) )
	vorbis? ( media-libs/libvorbis )"

RDEPEND="${DEPEND}"

src_configure() {
	econf --with-init-dir=/etc/init.d
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
