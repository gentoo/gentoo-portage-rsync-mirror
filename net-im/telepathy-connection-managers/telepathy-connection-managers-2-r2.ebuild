# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-connection-managers/telepathy-connection-managers-2-r2.ebuild,v 1.5 2014/12/27 15:49:45 eva Exp $

EAPI=5

DESCRIPTION="Meta-package for Telepathy Connection Managers"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI=""
LICENSE="metapackage"
SLOT="0"

KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-linux"

IUSE="icq +irc msn sip sipe +xmpp yahoo zeroconf"

DEPEND=""
# These version support the 0.24.0 Telepathy specification
# They work with Mission Control 5.14
RDEPEND="
	icq? ( >=net-voip/telepathy-haze-0.6.0 )
	irc? ( >=net-irc/telepathy-idle-0.1.14 )
	msn? ( >=net-voip/telepathy-gabble-0.16.4 )
	sip? ( >=net-voip/telepathy-rakia-0.7.4 )
	sipe? ( >=x11-plugins/pidgin-sipe-1.17.1[telepathy] )
	xmpp? ( >=net-voip/telepathy-gabble-0.16.4 )
	yahoo? ( >=net-voip/telepathy-haze-0.6.0 )
	zeroconf? ( >=net-voip/telepathy-salut-0.8.1 )
"
