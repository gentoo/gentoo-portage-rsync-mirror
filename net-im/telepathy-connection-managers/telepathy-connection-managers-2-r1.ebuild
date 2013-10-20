# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-connection-managers/telepathy-connection-managers-2-r1.ebuild,v 1.1 2013/10/20 07:48:11 pacho Exp $

EAPI=5
DESCRIPTION="Meta-package for Telepathy Connection Managers"

HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI=""
LICENSE="metapackage"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"

IUSE="msn +irc yahoo icq +jabber sip zeroconf"

DEPEND=""
# These version support the 0.24.0 Telepathy specification
# They work with Mission Control 5.14
RDEPEND="
	msn? ( >=net-voip/telepathy-gabble-0.16.4 )
	jabber? ( >=net-voip/telepathy-gabble-0.16.4 )
	sip? ( >=net-voip/telepathy-rakia-0.7.4 )
	zeroconf? ( >=net-voip/telepathy-salut-0.8.1 )
	icq? ( >=net-voip/telepathy-haze-0.6.0 )
	yahoo? ( >=net-voip/telepathy-haze-0.6.0 )
	irc? ( >=net-irc/telepathy-idle-0.1.14 )
"
