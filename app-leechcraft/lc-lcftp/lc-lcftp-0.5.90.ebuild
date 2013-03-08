# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-lcftp/lc-lcftp-0.5.90.ebuild,v 1.1 2013/03/08 22:00:52 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LCFTP, FTP client for LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
		>=net-misc/curl-7.19.4"
RDEPEND="${DEPEND}
		virtual/leechcraft-task-show"
