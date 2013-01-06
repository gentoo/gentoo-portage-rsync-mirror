# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/leechcraft-lcftp/leechcraft-lcftp-0.5.85.ebuild,v 1.1 2012/10/08 15:52:37 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LCFTP, FTP client for LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		>=net-misc/curl-7.19.4"
RDEPEND="${DEPEND}
		virtual/leechcraft-task-show"
