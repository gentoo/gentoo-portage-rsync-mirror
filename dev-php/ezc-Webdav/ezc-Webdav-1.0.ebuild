# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-Webdav/ezc-Webdav-1.0.ebuild,v 1.1 2011/12/14 22:26:46 mabi Exp $

EZC_BASE_MIN="1.4"
inherit php-ezc

DESCRIPTION="This eZ component allows to set up and run your own WebDAV (RFC 2518) server,
to enable online content editing for the users of your system through the WebDAV HTTP extension."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-lang/php-5.2.1"
