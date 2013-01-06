# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/leechcraft-vgrabber/leechcraft-vgrabber-0.5.85.ebuild,v 1.1 2012/10/08 16:07:42 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Allows to find, stream and save audio and video from VKontakte in LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}
		virtual/leechcraft-downloader-http"

pkg_postinst() {
	einfo "For streaming to work, a suitable media player plugin is"
	einfo "needed. For example, media-video/leechcraft-lmp will be just fine."
}
