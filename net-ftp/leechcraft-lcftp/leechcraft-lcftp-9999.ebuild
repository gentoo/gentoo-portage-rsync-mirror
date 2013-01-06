# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/leechcraft-lcftp/leechcraft-lcftp-9999.ebuild,v 1.2 2011/12/16 18:38:47 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LCFTP, FTP client for LeechCraft."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		>=net-misc/curl-7.19.4"
RDEPEND="${DEPEND}
		virtual/leechcraft-task-show"
