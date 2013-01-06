# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-bot-sentry/pidgin-bot-sentry-1.3.0.ebuild,v 1.3 2012/05/05 05:12:02 jdhore Exp $

EAPI="3"

inherit eutils multilib

MY_P="${P#pidgin-}"
DESCRIPTION="Bot Sentry is a Pidgin plugin to prevent Instant Message (IM) spam."
HOMEPAGE="http://pidgin-bs.sourceforge.net/"
SRC_URI="mirror://sourceforge/pidgin-bs/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/pidgin[gtk]
	x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
