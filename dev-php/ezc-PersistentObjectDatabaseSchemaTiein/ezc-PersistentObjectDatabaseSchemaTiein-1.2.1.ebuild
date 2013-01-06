# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-PersistentObjectDatabaseSchemaTiein/ezc-PersistentObjectDatabaseSchemaTiein-1.2.1.ebuild,v 1.1 2011/12/14 22:18:03 mabi Exp $

EZC_BASE_MIN="1.3.1"
inherit php-ezc

DESCRIPTION="This eZ component allows the automatic generation of PersistentObject definition files from DatabaseSchema definitions."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND}
	>=dev-php/ezc-PersistentObject-1.3
	>=dev-php/ezc-DatabaseSchema-1.2
	>=dev-php/ezc-ConsoleTools-1.3"
