# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-PersistentObject/ezc-PersistentObject-1.3.4.ebuild,v 1.1 2011/12/14 22:17:27 mabi Exp $

EZC_BASE_MIN="1.4.1"
inherit php-ezc

DESCRIPTION="This eZ component allows you to store an arbitrary data structures to a fixed database table."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-Database-1.3"
