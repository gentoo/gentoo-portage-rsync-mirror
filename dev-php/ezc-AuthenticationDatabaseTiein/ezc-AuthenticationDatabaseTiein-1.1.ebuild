# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-AuthenticationDatabaseTiein/ezc-AuthenticationDatabaseTiein-1.1.ebuild,v 1.1 2011/12/14 22:02:30 mabi Exp $

EZC_BASE_MIN="1.4"
inherit php-ezc

DESCRIPTION="This eZ component contains database writer backend for the Authentication component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-Authentication-1.1
	>=dev-php/ezc-Database-1.3"
